const express = require('express')
const cors = require("cors");
const credentials = require("./credentials")

const app = express()
app.use(express.json());
app.use(cors());

app.get('/api/auth', (req, res) =>{
    res.sendStatus(200)
})

app.post('/api/auth/login', (req, res) => {
    const { body } = req
    if (credentials[body.username] && credentials[body.username].password === body.password) {
        res.status(200).send({ msg: 'Authorisation successful' })
    } else {
        res.status(400).send({ msg: 'Authorisation unsuccessful - credentials incorrect' })
    }

})

app.post('/api/auth/register', (req, res) => {
    const { body } = req

    if (body.username && body.password) {
        if (!credentials[body.username]) {
            credentials[body.username] = { password: body.password }
            res.status(201).send({ msg: 'Registration successful' })
        } else {
            res.status(400).send({ msg: 'Registration unsuccessful - username already exists' })
        }
    } else {
        res.status(400).send({ msg: 'Registration unsuccessful - credentials missing' })
    }

})

app.use((err, req, res, next) => {
    if (err.status && err.msg) {
        res.status(err.status).send({ msg: err.msg });
    } else {
        next(err);
    }
});

app.use((err, req, res, next) => {
    res.status(500).send({ msg: "Internal Server Error" });
});

module.exports = app;
