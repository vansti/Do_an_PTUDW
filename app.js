var express = require('express');
var exphbs = require('express-handlebars');
var exphbs_section = require('express-handlebars-sections');
var path = require('path');
var bodyParser = require('body-parser')
var wnumb = require('wnumb');
var session = require('express-session');
var MySQLStore = require('express-mysql-session')(session);

var customerController = require('./controllers/customerController');
var userController = require('./controllers/userController');
var managerController = require('./controllers/managerController');
var handle404MDW = require('./middle-wares/handle404');
var handleLayoutMDW = require('./middle-wares/handleLayout')
var app = express();

app.engine('hbs', exphbs({
    defaultLayout: 'main',
    layoutsDir: 'views/_layouts/',
    helpers: {
        section: exphbs_section(),
        number_format: n => {
            var nf = wnumb({
                thousand: '.'
            });
            return nf.to(n);
        }
    }
}));

app.set('view engine', 'hbs');

app.use(express.static(
    path.resolve(__dirname, 'public')
));

app.use(bodyParser.urlencoded({
    extended: false
}));
app.use(bodyParser.json());

// session
var sessionStore = new MySQLStore({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '',
    database: 'camera_store',
    createDatabaseTable: true,
    schema: {
        tableName: 'sessions',
        columnNames: {
            session_id: 'session_id',
            expires: 'expires',
            data: 'data'
        }
    }
});

app.use(session({
    key: 'session_cookie_name',
    secret: 'session_cookie_secret',
    store: sessionStore,
    resave: false,
    saveUninitialized: false
}));

app.use(handleLayoutMDW);

app.get('/', (req, res) => {
    res.render('index');
});

app.use('/customer', customerController);
app.use('/manager', managerController);
app.use('/user', userController);

app.use(handle404MDW);

app.listen(3000, () => {
    console.log('server running on port 3000');
});