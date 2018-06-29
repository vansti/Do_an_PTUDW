var db = require('../fn/db');
var config = require('../config/config');
exports.loadPurchaseHistory = Ma_khach_hang => {
	var sql = `SELECT Ma_hoa_don, DATE_FORMAT(Ngay_dat_hang, '%Y-%m-%d') AS Ngay_dat_hang, Trang_thai, Tong_tien FROM hoa_don where Ma_khach_hang = ${Ma_khach_hang} ORDER BY Ngay_dat_hang DESC`;
	return db.load(sql);
}

exports.loadDetail = Ma_hoa_don => {
	var sql = `SELECT Ma_hoa_don, may_anh.Ten, may_anh.Don_gia_ban, So_luong FROM ct_hoa_don, may_anh WHERE ct_hoa_don.Ma_so = may_anh.Ma_so AND Ma_hoa_don = ${Ma_hoa_don}`;
	return db.load(sql);
}