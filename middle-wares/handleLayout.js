module.exports = (req, res, next) => {

    if (req.session.cart != undefined && req.session.user != undefined) {
		res.locals.layoutVM = {
            numItem: req.session.cart.length,
            userName: req.session.user.Ten_khach_hang
        };
    }
    // if (req.session.user === undefined) {
	// 	req.session.user = [];
	// }
    


    next();

};