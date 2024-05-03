const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

let newID = 1;
const lights = [{ id: 0, location: "Living Room", status: false }];

app.get("/api/lights", (req, res) => {
  res.status(200).send({ lights });
});

app.post("/api/lights", (req, res, next) => {
  const { body } = req;

  if (!body.location) next({ status: 400, msg: "No location included" });

  const newLight = { id: newID++, ...body, status: false };

  lights.push(newLight);

  res.status(201).send({ light: newLight });
});

app.post("/api/lights/switch", (req, res, next) => {
  const { body } = req;
  const { id } = body;

  if (id === undefined) {
    next({ status: 400, msg: "No ID included" });
  }
  if (typeof id !== "number") {
    next({ status: 400, msg: "ID must be an integer" });
  }

  const lightToToggle = lights.find((light) => {
    return light.id === id;
  });

  if (lightToToggle === undefined) {
    next({ status: 404, msg: "ID not found" });
  }

  lightToToggle.status = !lightToToggle.status;

  res.status(202).send({ light: lightToToggle });
});

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
