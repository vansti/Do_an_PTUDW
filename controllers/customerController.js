var express = require('express'),
    productRepo = require('../repos/productRepo');
    SHA256 = require('crypto-js/sha256'),
    moment = require('moment');

var xu_ly = require('../fn/xu_ly');
var request = require('request');
var config = require('../config/config');
var router = express.Router();

router.get('/home', (req, res) => {
    var vm = {};
    productRepo.loadMostviewed().then(rows => {
        
        vm.mostviewed1 = xu_ly.chuoi1(rows)
        vm.mostviewed2 = xu_ly.chuoi2(rows)
        vm.mostviewed3 = xu_ly.chuoi3(rows)

        productRepo.loadBestselling().then(rows => {
            
            vm.bestselling1 = xu_ly.chuoi1(rows)
            vm.bestselling2 = xu_ly.chuoi2(rows)
            vm.bestselling3 = xu_ly.chuoi3(rows)

            productRepo.loadLatest().then(rows => {
                
                vm.latest = rows
                res.render('customer/home', vm);
            });

        });
    });
});



router.get('/products/:id', (req, res) => {
    var pid = req.params.id;

    var page = req.query.page;

    if (!page) {
        page = 1;
    }

    var offset = (page - 1) * config.PRODUCTS_PER_PAGE;

    var p1 = productRepo.loadAllByID(pid, offset);
    var p2 = productRepo.countByID(pid);
    Promise.all([p1, p2]).then(([pRows, countRows]) => {

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
            title: pid
        };
        res.render('customer/products', vm);
    });
});

router.get('/products?', (req, res) => {
    var price = req.query.price;
    var name = req.query.name; 
    var page = req.query.page;
    if (!page) {
        page = 1;
    }
    var offset = (page - 1) * config.PRODUCTS_PER_PAGE;

    var p1 = productRepo.loadAllByNP(price, name , offset);
    var p2 = productRepo.countByNP(price, name);
    Promise.all([p1, p2]).then(([pRows, countRows]) => {

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
            title: "Products found"
        };
        res.render('customer/products', vm);
    });
});

router.get('/product_details/:id', (req, res) => {
    var pid = req.params.id;
    var vm = {};
    
    xu_ly.connectDatabase().query("select * from may_anh where Ma_so = ?;", [pid], function (err, row) {
        if (err) throw err;
        vm.product = row[0]

        xu_ly.connectDatabase().query("select * from may_anh WHERE Hang= ? AND Ma_so != ? ORDER BY Rand() limit 5", [row[0].Hang, pid], function (err, rows) {
            if (err) throw err;
            
            vm.relatedBrand = rows

            xu_ly.connectDatabase().query("select * from may_anh WHERE Loai= ? AND Ma_so != ? ORDER BY Rand() limit 5", [row[0].Loai, pid], function (err, rows) {
                if (err) throw err;
                
                vm.relatedType = rows

                res.render('customer/product_details', vm)
            })
        })
    })
    xu_ly.connectDatabase().query("update may_anh set So_luot_xem = So_luot_xem + 1 Where Ma_so = ?",[pid],function (err, row) {})
});

router.get('/register', (req, res) => {
    var vm = {
        successResult: false,
        errResult: false
    }
    res.render('customer/register', vm);
});



router.post('/addUser', (req, res) => {
    if (
        req.body['g-recaptcha-response'] === undefined ||
        req.body['g-recaptcha-response'] === '' ||
        req.body['g-recaptcha-response'] === null
    ) {
        var vm = {
            successResult: false,
            errResult: true,
            errShow: 'Please select captcha before submit'
        }
        res.render('customer/register', vm);
        return;
    }

    if (req.body.Mat_khau != req.body.CMat_khau) {
        var vm = {
            successResult: false,
            errResult: true,
            errShow: 'Your password and confirmation password do not match.'
        }
        res.render('customer/register', vm);
        return;
    }

    xu_ly.connectDatabase().query("SELECT * FROM khach_hang WHERE Email = ?", [req.body.Email.toLowerCase()], function (err, row) {
        if (err) throw err;
        if (row.length != 0) {
            var vm = {
                successResult: false,
                errResult: true,
                errShow: 'Email has already been taken'
            }
            res.render('customer/register', vm);
            return;
        } else {
            // Secret Key
            const secretKey = '6LedcFgUAAAAAFK_EMLf6nPnXZUPDUmOQcnJ1fxb';

            // Verify URL
            const verifyUrl = `https://google.com/recaptcha/api/siteverify?secret=${secretKey}&response=${req.body['g-recaptcha-response']}&remoteip=${req.connection.remoteAddress}`;

            // Make Request To VerifyURL
            request(verifyUrl, (err, response, body) => {
                body = JSON.parse(body);

                // If Not Successful
                if (body.success !== undefined && !body.success) {
                    var vm = {
                        successResult: false,
                        errResult: true,
                        errShow: 'Failed captcha validation'
                    }
                    res.render('customer/register', vm);
                    return;
                }

                //If Successful
                const userdata = {
                    Email: req.body.Email.toLowerCase(),
                    Ten_khach_hang: req.body.Ten_khach_hang,
                    Gioi_tinh: req.body.Gioi_tinh,
                    Ngay_sinh: req.body.Ngay_sinh,
                    Mat_khau: SHA256(req.body.Mat_khau).toString(),
                    So_dien_thoai: req.body.So_dien_thoai,
                    Dia_chi: req.body.Dia_chi
                }
                xu_ly.connectDatabase().query("INSERT INTO khach_hang SET ?", userdata, function (err, row) {
                    if (err) throw err;
                    var vm = {
                        successResult: true,
                        errResult: false
                    }
                    res.render('customer/register', vm);
                })

            });

        }
    })


});


module.exports = router;