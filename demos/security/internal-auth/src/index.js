var express = require('express');
var bodyParser = require('body-parser');
var jwt = require('jsonwebtoken');

var app = express();

app.use(bodyParser.json());

app.post('/login', (req, res, next) => {
  res.json({
    jwt: jwt.sign(req.body, 'topsecrettoken', { expiresIn: '1800s' })
  });
});

app.listen(3030);
