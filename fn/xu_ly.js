module.exports = {
    connectDatabase: () => {
        var mysql = require('mysql');
        var cn = mysql.createConnection({
            host: 'localhost',
            port: 3306,
            user: 'root',
            password: '',
            database: 'camera_store'
        });
        cn.connect();
        return cn;
    },
    chuoi1(rows){
        var a = []
        for (var i = 0; i < 4; i++) {
            a.push(rows[i])
        }
        return a;
    },
    
    chuoi2(rows){
        var a = []
        for (var i = 4; i < 8; i++) {
            a.push(rows[i])
        }
        return a;
    },
    
    chuoi3(rows){
        var a = []
        for (var i = 8; i < 10; i++) {
            a.push(rows[i])
        }
        return a;
    }
}