var users = [{ name: 'me'}];

function createUser(req, res) {
    var newUser = { name:req.body.name };
    users.push(newUser);
    res.send(201, newUser);
}


function indexOfUser(name) {
    for(var i = 0; i < users.length; i++) {
        if (users[i].name === name) return i;
    }
    return -1;
}


function getUser(req, res) {
    var index = indexOfUser(decodeURIComponent(req.param('name')));
    index > 0 ? res.json(200, users[index]) :  res.send(404, 'no such user');
}


function deleteUser(req, res) {
    var index = indexOfUser(decodeURIComponent(req.param('name')));
    if (index > 0) {
        users.splice(index, 1);
        res.send(204);
        return;
    }
    res.send(404, 'no such user');
}


var express = require('express');

var app = express();
app.configure(function () {
//  app.use(express.logger({immediate: true, stream: process.stderr}));
    app.use(express.logger());
    app.use(express.compress());
    app.use(express.bodyParser());
});

app.post('/users', createUser);
app.get('/users/:name', getUser);
app.delete('/users/:name', deleteUser);


var port = process.env.PORT || 5500;
var ip = '0.0.0.0';

app.listen(port, ip, function() {
    console.log('NODE VERSION: ' + process.version);
    console.log('LISTENING ON ' + ip + ':' + port);
});
