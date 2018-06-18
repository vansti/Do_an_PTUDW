module.exports = (req, res, next) => {
    if (req.session.manager) {
        next();
    } else {
        res.redirect('/manager/login');
    }
}