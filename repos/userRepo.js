var db = require('../fn/db');
var config = require('../config/config');
exports.loadUser = Ma_khach_hang => {
	var sql = `SELECT *,DATE_FORMAT(Ngay_sinh, '%Y-%m-%d') AS Ngay_sinh from khach_hang where Ma_khach_hang = ${Ma_khach_hang}`;
	return db.load(sql);
}