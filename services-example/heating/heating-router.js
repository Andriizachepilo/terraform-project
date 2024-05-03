const express = require('express')
const router = express.Router()

const heating = { temperature: 21 };

router.get('/healthcheck', (req, res) => {
  res.status(200).send({ health: "OK" });
});

router.get("/", (req, res) => {
  res.status(200).send(heating);
});

router.post("/", (req, res, next) => {
  const { body } = req;

  if (!body.temperature) {
    res.status(400).send({ status: 400, msg: "No temperature included" });
  }

  heating.temperature = body.temperature

  res.status(201).send(heating);
});

module.exports = router