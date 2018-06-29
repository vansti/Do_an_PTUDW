var express = require('express'),
    productRepo = require('../repos/productRepo');
    orderRepo = require('../repos/orderRepo');
    userRepo = require('../repos/userRepo');
    categoryRepo = require('../repos/categoryRepo');
var restrict = require('../middle-wares/restrictUser');
var xu_ly = require('../fn/xu_ly');
var request = require('request');
var config = require('../config/config');
var SHA256 = require('crypto-js/sha256');
var router = express.Router();


router.get('/login', (req, res) => {
    res.render('user/login')
});

router.post('/login', (req, res) => {
    var user = {
        Email: req.body.Email,
        Mat_khau: SHA256(req.body.Mat_khau).toString()
    };

    xu_ly.connectDatabase().query("select * from khach_hang where Email = ? AND Mat_khau = ?", [user.Email, user.Mat_khau], function (err, rows) {
        if (rows.length > 0) {
            req.session.user = rows[0];
            req.session.cart = [];
            var url = '/user/home';
            if (req.query.retUrl) {
                url = req.query.retUrl;
            }
            res.redirect(url);
            return;

        } else {
            var vm = {
                showError: true,
                errorMsg: 'Login failed'
            };
            res.render('user/login', vm);
        }
    });
});


router.get('/home', restrict, (req, res) => {
    var vm = {};
    var vm = {};
    var p1 = productRepo.loadMostviewed();
    var p2 = productRepo.loadBestselling();
    var p3 = productRepo.loadLatest();
    var p4 = categoryRepo.loadBrand();
    var p5 = categoryRepo.loadType();
    Promise.all([p1, p2, p3, p4, p5]).then(([Mostviewed, Bestselling, Latest, Brand, Type]) => {
        vm.mostviewed1 = xu_ly.chuoi1(Mostviewed)
        vm.mostviewed2 = xu_ly.chuoi2(Mostviewed)
        vm.mostviewed3 = xu_ly.chuoi3(Mostviewed)
        vm.bestselling1 = xu_ly.chuoi1(Bestselling)
        vm.bestselling2 = xu_ly.chuoi2(Bestselling)
        vm.bestselling3 = xu_ly.chuoi3(Bestselling)
        vm.latest = Latest;
        vm.brand = Brand;
        vm.type = Type;
        res.render('user/home', vm);
    })
});



router.get('/products/:id', restrict, (req, res) => {
    var pid = req.params.id;

    var page = req.query.page;

    if (!page) {
        page = 1;
    }

    var offset = (page - 1) * config.PRODUCTS_PER_PAGE;

    var p1 = productRepo.loadAllByID(pid, offset);
    var p2 = productRepo.countByID(pid);
    var p4 = categoryRepo.loadBrand();
    var p5 = categoryRepo.loadType();
    Promise.all([p1, p2, p4, p5]).then(([pRows, countRows, Brand, Type]) => {

        var total = countRows[0].total;
        var nPages = total / config.PRODUCTS_PER_PAGE;
        if (total % config.PRODUCTS_PER_PAGE > 0) {
            nPages++;
        }

        var numbers = [];
        for (i = 1; i <= nPages; i++) {
            numbers.push({
                value: i,
                isCurPage: i === +page
            });
        }

        var vm = {
            products: pRows,
            noProducts: pRows.length === 0,
            page_numbers: numbers,
            amount: total,
            title: pid,
            brand: Brand,
            type: Type
        };

        res.render('user/products', vm);
    });
});

router.get('/products?', restrict, (req, res) => {
    var price = req.query.price;
    var name = req.query.name;
    var page = req.query.page;
    if (!page) {
        page = 1;
    }
    var offset = (page - 1) * config.PRODUCTS_PER_PAGE;

    var p1 = productRepo.loadAllByNP(price, name, offset);
    var p2 = productRepo.countByNP(price, name);
    var p4 = categoryRepo.loadBrand();
    var p5 = categoryRepo.loadType();
    Promise.all([p1, p2, p4, p5]).then(([pRows, countRows, Brand, Type]) => {

        var total = countRows[0].total;
        var nPages = total / config.PRODUCTS_PER_PAGE;
        if (total % config.PRODUCTS_PER_PAGE > 0) {
            nPages++;
        }

        var numbers = [];
        for (i = 1; i <= nPages; i++) {
            numbers.push({
                value: i,
                isCurPage: i === +page,
                price: price,
                name: name,
                isSearch: true
            });
        }
        var vm = {
            products: pRows,
            noProducts: pRows.length === 0,
            page_numbers: numbers,
            amount: total,
            title: "Products found",
            brand: Brand,
            type: Type
        };
        res.render('user/products', vm);
    });
});

router.get('/product_details/:id', restrict, (req, res) => {
    var pid = req.params.id;
    var vm = {

    };
    xu_ly.connectDatabase().query("select * from may_anh where Ma_so = ?;", [pid], function (err, row) {
        if (err) throw err;
        vm.product = row[0]

        xu_ly.connectDatabase().query("select * from may_anh WHERE Hang= ? AND Ma_so != ? ORDER BY Rand() limit 5", [row[0].Hang, pid], function (err, rows) {
            if (err) throw err;
            vm.relatedBrand = rows

            xu_ly.connectDatabase().query("select * from may_anh WHERE Loai= ? AND Ma_so != ? ORDER BY Rand() limit 5", [row[0].Loai, pid], function (err, rows) {
                if (err) throw err;
                vm.relatedType = rows

                xu_ly.connectDatabase().query("update may_anh set So_luot_xem = So_luot_xem + 1 Where Ma_so = ?", [pid], function () {
                    var p4 = categoryRepo.loadBrand();
                    var p5 = categoryRepo.loadType();
                    Promise.all([p4, p5]).then(([Brand, Type]) => {
                        vm.brand = Brand;
                        vm.type = Type;
                        res.render('user/product_details', vm)
                    })
                })

            })
        })
    })

});


router.post('/addItem', (req, res) => {
    var cart = req.session.cart
    if (cart.indexOf(req.body.Ma_so) == -1) {
        cart.push(req.body.Ma_so);
    }
    res.redirect(req.headers.referer);
})

router.get('/cart', restrict , (req, res) => {

    if (req.session.cart.length == 0) {
        res.redirect('home');
    } else {
        var arr_p = [];
        for (var i = 0; i < req.session.cart.length; i++) {
            var cartItem = req.session.cart[i];
            var p = productRepo.single(cartItem);
            arr_p.push(p);
        }

        var items = [];
        Promise.all(arr_p).then(result => {
            for (var i = result.length - 1; i >= 0; i--) {
                var pro = result[i][0];
                var item = {
                    Product: pro
                };
                items.push(item);
            }

            var vm = {
                items: items
            };
            res.render('user/cart', vm);
        });
    }

});

router.post('/removeItem', (req, res) => {
    var cart = req.session.cart
    for (var i = cart.length - 1; i >= 0; i--) {
        if (req.body.Ma_so == cart[i]) {
            cart.splice(i, 1);
        }
    }
    res.redirect(req.headers.referer);
});

router.post('/addOrder', (req, res) => {
    var Tong_tien = req.body.totalPrice
    delete req.body.totalPrice

    var order = {
        Tong_tien: Tong_tien,
        Ma_khach_hang: req.session.user.Ma_khach_hang
    }
    xu_ly.connectDatabase().query("INSERT INTO hoa_don SET ?", order, function (err) {
        if (err) throw err;
        xu_ly.connectDatabase().query("SELECT max(Ma_hoa_don) as Ma_hoa_don FROM hoa_don", function (err, row) {
            if (err) throw err;
            for (var key in req.body) {
                item = req.body[key];
                var order_detail = {
                    Ma_hoa_don: row[0].Ma_hoa_don,
                    Ma_so: key,
                    So_luong: item
                }
                xu_ly.connectDatabase().query("update may_anh set So_luong_ban = So_luong_ban + 1 * ? Where Ma_so = ?", [order_detail.So_luong, order_detail.Ma_so], function () {
                    xu_ly.connectDatabase().query("INSERT INTO ct_hoa_don SET ?", order_detail, function (err) {
                        if (err) throw err;
                    })
                })

            }
            req.session.cart = [];
            var vm = {
                success: true
            }
            res.render('user/cart', vm);
        })
    })

});


router.get('/purchase_history', restrict , (req, res) => {
    var p1 = orderRepo.loadPurchaseHistory(req.session.user.Ma_khach_hang)
    var p4 = categoryRepo.loadBrand();
    var p5 = categoryRepo.loadType();
    Promise.all([p1, p4, p5]).then(([Order, Brand, Type]) => {
        var vm = {};
        vm.brand = Brand;
        vm.type = Type;
        vm.order = Order;
        res.render('user/purchase_history', vm)
    })
});

router.get('/detail_ph?', restrict ,(req, res) => {
    var Ma_hoa_don = req.query.id;
    var p1 = orderRepo.loadDetail(Ma_hoa_don)
    var p4 = categoryRepo.loadBrand();
    var p5 = categoryRepo.loadType();
    Promise.all([p1, p4, p5]).then(([Order_detail, Brand, Type]) => {
        var vm = {};
        vm.brand = Brand;
        vm.type = Type;
        vm.order_detail = Order_detail
        res.render('user/detail_ph', vm)
    })
});


router.get('/profile', restrict , (req, res) => {
    var p1 = userRepo.loadUser(req.session.user.Ma_khach_hang)
    var p4 = categoryRepo.loadBrand();
    var p5 = categoryRepo.loadType();
    Promise.all([p1, p4, p5]).then(([User, Brand, Type]) => {
        var vm = {};
        vm.brand = Brand;
        vm.type = Type;
        vm.user = User[0];
        res.render('user/profile', vm);
    })
});

router.get('/change_password', restrict , (req, res) => {
    var p4 = categoryRepo.loadBrand();
    var p5 = categoryRepo.loadType();
    Promise.all([p4, p5]).then(([Brand, Type]) => {
        var vm = {};
        vm.brand = Brand;
        vm.type = Type;
        res.render('user/change_password', vm);
    })
})

router.post('/change_password', restrict , (req, res) => {
    var confirm_password = SHA256(req.body.confirm_password).toString()
    if(confirm_password == req.session.user.Mat_khau)      
    {
        var new_password = SHA256(req.body.new_password).toString()
        var Ma_khach_hang = req.session.user.Ma_khach_hang
        
        var sql = "update khach_hang set Mat_khau = ? where Ma_khach_hang = ?"
        xu_ly.connectDatabase().query(sql, [new_password, Ma_khach_hang], function (err, rows) {
            var vm = {
                success: true
            }
            res.render('user/change_password', vm);
            return;
        })
        
    }
    else
    {
        var vm = {
            error: true
        }
        res.render('user/change_password', vm);
    }
})

router.post('/profile', (req, res) => {
    const userdata = [
        Email = req.body.Email.toLowerCase(),
        Ten_khach_hang = req.body.Ten_khach_hang,
        Gioi_tinh = req.body.Gioi_tinh,
        Ngay_sinh = req.body.Ngay_sinh,
        So_dien_thoai = req.body.So_dien_thoai,
        Dia_chi = req.body.Dia_chi,
        Ma_khach_hang = req.session.user.Ma_khach_hang
    ]
    var sql = "update khach_hang set Email = ?, Ten_khach_hang = ?, Gioi_tinh=?, Ngay_sinh=?, So_dien_thoai=?, Dia_chi=? where Ma_khach_hang = ?"
    xu_ly.connectDatabase().query(sql, userdata, function (err, rows) {
        if (err) throw err;
        var vm = {
            success: true
        }
        res.render('user/profile', vm);
    })
});

router.post('/logout', (req, res) => {
    req.session.user = null;
    req.session.cart = [];
    res.redirect("/customer/home");
});
module.exports = router;