var db = require('../fn/db');
var config = require('../config/config');
exports.loadBrand = () => {
	var sql = 'select * from hang';
	return db.load(sql);
}

exports.loadType = () => {
	var sql = 'select * from loai';
	return db.load(sql);
}

exports.addBrand = Ten_hang => {
	var sql = `INSERT INTO hang (Ten_hang) VALUES (${Ten_hang})`
	return db.save(sql);
}

exports.addType = Ten_loai => {
	var sql = `INSERT INTO loai (Ten_loai) VALUES (${Ten_loai})`
	return db.load(sql);
}

exports.deleteBrand = Ma_hang => {
	var sql = `DELETE FROM hang WHERE Ma_hang = ${Ma_hang}`
	return db.save(sql);
}