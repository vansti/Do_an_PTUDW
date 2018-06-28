var db = require('../fn/db');
var config = require('../config/config');
exports.loadPurchaseHistory = Ma_khach_hang => {
	var sql = `SELECT Ma_hoa_don, DATE_FORMAT(Ngay_dat_hang, '%Y-%m-%d') AS Ngay_dat_hang, Trang_thai, Tong_tien FROM hoa_don where Ma_khach_hang = ${Ma_khach_hang} ORDER BY Ngay_dat_hang DESC`;
	return db.load(sql);
}