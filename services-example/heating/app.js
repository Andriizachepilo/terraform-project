const express = require("express");
const cors = require("cors");
const heatingRouter = require('./heating-router')

const app = express();
app.use(cors());
app.use(express.json());
app.use('/api/heating', heatingRouter);

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
