var express = require('express');
var categoryRepo = require('../repos/categoryRepo');
var router = express.Router();
var multer = require('multer');
var xu_ly = require('../fn/xu_ly');
var restrict = require('../middle-wares/restrictManager');
var SHA256 = require('crypto-js/sha256');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './public/themes/images/products/');
    },
    filename: function (req, file, cb) {
        cb(null, file.originalname);
    }
})

const fileFilter = (req, file, cb) => {
    if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png')
        cb(null, true)
    else {
        req.fileValidationError = 'Error! Wrong mimetype picture of product ( just .jpg and .png only). Please reup the product';
        return cb(null, false, new Error('goes wrong on the mimetype'));
    }
};

const upload = multer({
    storage: storage,
    fileFilter: fileFilter
});

router.get('/login', (req, res) => {
    res.render('manager/login')
});

router.post('/login', (req, res) => {
    var user = {
        Email: req.body.Email,
        Mat_khau: SHA256(req.body.Mat_khau).toString()
    };

    xu_ly.connectDatabase().query("select * from quan_ly where Email = ? AND Mat_khau = ?", [user.Email, user.Mat_khau], function (err, rows) {
        if (rows.length > 0) {
            req.session.manager = rows[0];
            res.redirect('/manager/home');
            return;

        } else {
            var vm = {
                showError: true,
                errorMsg: 'Login failed'
            };
            res.render('manager/login', vm);
        }
    });
});

router.get('/home', restrict, (req, res) => {
    var vm = {
        managerName: req.session.manager.Ten_quan_ly
    };
    res.render('manager/home', vm);
});

router.get('/add_brand_type', restrict, (req, res) => {
    var vm = {};
    res.render('manager/add_brand_type', vm);
});



router.post('/add_brand', restrict, (req, res) => {
    var Ten_hang = req.body.Ten_hang
    xu_ly.connectDatabase().query("INSERT INTO hang (Ten_hang) VALUES (?)", [Ten_hang], function (err) {
        if (err) throw err;
        var vm = {
            successResultB: true
        }
        res.render('manager/add_brand_type', vm);
        return;
    })
});

router.post('/add_type', restrict, (req, res) => {
    var Ten_loai = req.body.Ten_loai
    xu_ly.connectDatabase().query("INSERT INTO loai (Ten_loai) VALUES (?)", [Ten_loai], function (err) {
        if (err) throw err;
        var vm = {
            successResultT: true
        }
        res.render('manager/add_brand_type', vm);
        return;
    })
});

router.get('/update_product', restrict, (req, res) => {
    xu_ly.connectDatabase().query("select * from may_anh where Hang = 'Canon'", function (err, rows) {
        if (err) throw err;
        var vm = {
            products: rows,
            managerName: req.session.manager.Ten_quan_ly
        };
        var p4 = categoryRepo.loadBrand();
        var p5 = categoryRepo.loadType();
        Promise.all([p4, p5]).then(([Brand, Type]) => {
            vm.brand = Brand;
            vm.type = Type;
            res.render('manager/update_product', vm);
        })

    })

});

router.get('/delete_brand', restrict, (req, res) => {
    
    var p1 = categoryRepo.loadBrand();
    Promise.all([p1]).then(([Brand]) => {
        var vm = {
            brand: Brand
        };
        res.render('manager/delete_brand', vm);
    })

});

router.get('/delete_type', restrict, (req, res) => {
    
    var p1 = categoryRepo.loadType();
    Promise.all([p1]).then(([Type]) => {
        var vm = {
            type: Type
        };
        res.render('manager/delete_type', vm);
    })

});

router.post('/removeBrand', restrict, (req, res) => {
    categoryRepo.deleteBrand(req.body.Ma_hang);
    res.redirect(req.headers.referer);
})

router.post('/removeType', restrict, (req, res) => {
    categoryRepo.deleteType(req.body.Ma_loai);
    res.redirect(req.headers.referer);
})

router.get('/update_product/:id', restrict, (req, res) => {
    var pid = req.params.id;
    xu_ly.connectDatabase().query("select * from may_anh where Hang = ?", [pid], function (err, rows) {
        if (err) throw err;
        var vm = {
            products: rows,
            managerName: req.session.manager.Ten_quan_ly
        };
        var p4 = categoryRepo.loadBrand();
        var p5 = categoryRepo.loadType();
        Promise.all([p4, p5]).then(([Brand, Type]) => {
            vm.brand = Brand;
            vm.type = Type;
            res.render('manager/update_product', vm);
        })
    })

});

router.get('/edit?', restrict, (req, res) => {
    var Ma_so = req.query.id;
    xu_ly.connectDatabase().query("select * from may_anh where Ma_so = ?", [Ma_so], function (err, rows) {
        if (err) throw err;
        var vm = {
            product: rows[0],
            check: false,
            managerName: req.session.manager.Ten_quan_ly
        };
        res.render('manager/edit', vm)
    })


});

router.post('/edit', (req, res) => {
    var Don_gia_ban = req.body.Don_gia_ban;
    var Mo_ta = req.body.Mo_ta;
    var Ma_so = req.body.Ma_so;
    xu_ly.connectDatabase().query("update may_anh set Don_gia_ban = ? , Mo_ta = ? Where Ma_so=?", [Don_gia_ban, Mo_ta, Ma_so], function (err, rows) {
        if (err) throw err;
        var vm = {
            check: true
        }
        res.render('manager/edit', vm)
    })
});

router.get('/delete?', restrict, (req, res) => {
    var Ma_so = req.query.id;
    var Hang = req.query.brand;
    xu_ly.connectDatabase().query("delete from may_anh where Ma_so = ?", [Ma_so], function (err, row) {
        if (err) throw err;
        xu_ly.connectDatabase().query("Select * from may_anh where Hang = ?", [Hang], function (err, rows) {
            var vm = {
                products: rows,
                managerName: req.session.manager.Ten_quan_ly
            };
            res.render('manager/update_product', vm)
        })
    })
});

router.get('/add_product', restrict, (req, res) => {
    var vm = {
        managerName: req.session.manager.Ten_quan_ly
    }
    var p4 = categoryRepo.loadBrand();
    var p5 = categoryRepo.loadType();
    Promise.all([p4, p5]).then(([Brand, Type]) => {
        vm.brand = Brand;
        vm.type = Type;
        res.render('manager/add_product', vm);
    })


});

router.post('/add_product', upload.single('Hinh_anh'), (req, res) => {
    if (req.fileValidationError) {
        return res.end(req.fileValidationError);
    }
    const productdata = {
        Ten: req.body.Ten,
        Don_gia_ban: req.body.Don_gia_ban,
        Hang: req.body.Hang,
        Loai: req.body.Loai,
        Mo_ta: req.body.Mo_ta,
        Hinh_anh: req.file.originalname
    }
    xu_ly.connectDatabase().query("INSERT INTO may_anh SET ?", productdata, function (err, row) {
        if (err) throw err;
        var vm = {
            successResult: true
        }
        res.render('manager/add_product', vm);

        return;
    })
});

router.get('/update_order', restrict, (req, res) => {
    var sql = "SELECT hoa_don.Ma_hoa_don, DATE_FORMAT(hoa_don.Ngay_dat_hang, '%Y-%m-%d') AS Ngay_dat_hang, hoa_don.Trang_thai, hoa_don.Tong_tien, khach_hang.Ten_khach_hang FROM hoa_don JOIN khach_hang ON hoa_don.Ma_khach_hang = khach_hang.Ma_khach_hang ORDER BY hoa_don.Ngay_dat_hang DESC"
    xu_ly.connectDatabase().query(sql, function (err, rows) {
        var vm = {
            order: rows,
            managerName: req.session.manager.Ten_quan_ly
        }
        res.render('manager/update_order', vm);
    })
});

router.get('/updateOrder?', restrict, (req, res) => {
    var Ma_hoa_don = req.query.id;
    var Trang_thai = req.query.newstt;
    xu_ly.connectDatabase().query("update hoa_don set Trang_thai = ? Where Ma_hoa_don=?", [Trang_thai, Ma_hoa_don], function (err, row) {
        if (err) throw err;
        var sql = "SELECT hoa_don.Ma_hoa_don, DATE_FORMAT(hoa_don.Ngay_dat_hang, '%Y-%m-%d') AS Ngay_dat_hang, hoa_don.Trang_thai, hoa_don.Tong_tien, khach_hang.Ten_khach_hang FROM hoa_don JOIN khach_hang ON hoa_don.Ma_khach_hang = khach_hang.Ma_khach_hang ORDER BY hoa_don.Ngay_dat_hang DESC"
        xu_ly.connectDatabase().query(sql, function (err, rows) {
            var vm = {
                order: rows,
                managerName: req.session.manager.Ten_quan_ly
            }
            res.render('manager/update_order', vm);
        })

    })
});

router.post('/logout', (req, res) => {
    req.session.manager = null;
    res.redirect("/");
});
module.exports = router;