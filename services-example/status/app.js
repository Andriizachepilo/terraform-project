const express = require("express");
const cors = require("cors");
const axios = require("axios");
const loggedInUser = require("./loggedInUser");

require("dotenv").config({ path: "./.env.local" });

const app = express();
app.use(express.json());
app.use(cors());

app.get("/api/status/health", (_, res) => {
  res.sendStatus(200);
});

app.get("/api/status", async (req, res, next) => {
  try {
    const data = {};

    // Fetch lighting status
    const lightsPromise = axios
      .get(`${process.env.LIGHTS_SERVICE}/api/lights`)
      .then(({ data: lightsData }) => {
        data.lighting = { status: true, lights: lightsData.lights };
      })
      .catch(() => {
        data.lighting = { status: false };
      });

    // Fetch heating status
    const heatingPromise = axios
      .get(`${process.env.HEATING_SERVICE}/api/heating`)
      .then(({ data: heatingData }) => {
        data.heating = { status: true, ...heatingData };
      })
      .catch(() => {
        data.heating = { status: false };
      });

    // Fetch auth status
    const authPromise = axios
      .get(`${process.env.AUTH_SERVICE}/api/auth`)
      .then(() => {
        data.auth = { status: true, info: { ...loggedInUser } };
      })
      .catch(() => {
        data.auth = { status: false };
      });

    await Promise.allSettled([lightsPromise, heatingPromise, authPromise]);

    res.status(200).send(data);
  } catch (err) {
    next(err);
  }
});

app.post("/api/status/login", (req, res) => {
  const { body } = req;

  axios
    .post(`${process.env.AUTH_SERVICE}/api/auth/login`, {
      username: body.username,
      password: body.password,
    })
    .then(({ status, data }) => {
      loggedInUser.loggedIn = true;
      loggedInUser.username = body.username;
      res.status(status).send(data);
    })
    .catch(({ response }) => {
      res.status(response.status).send(response.data);
    });
});

app.post("/api/status/register", (req, res) => {
  const { body } = req;
  axios
    .post(`${process.env.AUTH_SERVICE}/api/auth/register`, {
      username: body.username,
      password: body.password,
    })
    .then(({ status, data }) => {
      res.status(status).send(data);
    })
    .catch(({ response }) => {
      res.status(response.status).send(response.data);
    });
});

app.post("/api/status/logout", (req, res) => {
  loggedInUser.loggedIn = false;
  loggedInUser.username = null;
  res.status(200).send({ msg: "Logged out successfully" });
});

app.use((err, req, res, next) => {
  console.log(err);
  res.status(500).send({ err });
});

module.exports = app;
