var db = require('../fn/db');
var config = require('../config/config');
exports.loadAll = () => {
	var sql = 'select * from may_anh';
	return db.load(sql);
}

exports.loadBrand = () => {
	var sql = 'select * from hang';
	return db.load(sql);
}

exports.loadType = () => {
	var sql = 'select * from loai';
	return db.load(sql);
}

exports.loadMostviewed = () => {
	var sql = 'select * from may_anh order by So_luot_xem desc limit 10';
	return db.load(sql);
}

exports.loadBestselling = () => {
	var sql = 'select * from may_anh order by So_luong_ban desc limit 10';
	return db.load(sql);
}

exports.loadLatest = () => {
	var sql = 'select * from may_anh order by Ngay_tiep_nhan desc limit 9';
	return db.load(sql);
}

exports.loadAllByID = (pid, offset) => {
    var sql = `select * from may_anh where Hang = '${pid}' OR Loai = '${pid}' limit ${config.PRODUCTS_PER_PAGE} offset ${offset}`;
    return db.load(sql);
}

exports.countByID = pid => {
	var sql = `select count(*) as total from may_anh where Hang = '${pid}' OR Loai = '${pid}'`;
    return db.load(sql);
}

exports.loadAllByNP = (price, name, offset) => {
    var sql = `select * from may_anh where Ten LIKE '%${name}%' AND Don_gia_ban <= ${price} limit ${config.PRODUCTS_PER_PAGE} offset ${offset}`;
    return db.load(sql);
}

exports.countByNP = (price, name) => {
	var sql = `select count(*) as total from may_anh where Ten LIKE '%${name}%' AND Don_gia_ban <= ${price}`;
    return db.load(sql);
}
exports.single = Ma_so => {
    var sql = `select * from may_anh where Ma_so = ${Ma_so}`;
    return db.load(sql);
}

// exports.updateview = Ma_so => {
//     var sql = `update may_anh set So_luot_xem = So_luot_xem + 1 Where Ma_so = ${Ma_so}`;
//     return db.save(sql);
// }