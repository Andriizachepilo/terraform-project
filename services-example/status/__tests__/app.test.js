// This test suit relies on the lights and heating services being available. You can supply the URL for these services via an env file in the format of the example

const request = require("supertest");
const app = require("../app");
const loggedInUser = require('../loggedInUser')


describe("Status Service", () => {
  test("GET /api/status/health - should respond with 200 ", async () => {
    await request(app).get("/api/status/health").expect(200);
  });

  test("GET /api/status - should return an object containing the lights information", async () => {
    const {
      body: { lighting },
    } = await request(app).get("/api/status");

    expect(lighting.lights.length).toBeGreaterThan(0);
    expect(lighting.status).toBe(true);
    lighting.lights.forEach((light) => {
      expect(light).toEqual(
        expect.objectContaining({
          location: expect.any(String),
          status: expect.any(Boolean),
        })
      );
    });
  });

  test("GET /api/status - should return an object containing the heating information", async () => {
    const { body } = await request(app).get("/api/status");

    expect(typeof body.heating.temperature).toBe("number");
  });

  test("GET /api/status - should return an object containing the logged in user information", async () => {
    await request(app).post("/api/status/login").send({ username: 'cloudUser', password: 'cloudIsC00l' }).expect(200)
    const { body } = await request(app).get("/api/status");

    expect(body.auth).toEqual({
      loggedIn: true, username: 'cloudUser'
    });
  });

  describe('Authentication', () => {
    describe('/api/status/login', () => {
      test('POST /api/status/login - should respond with success message if credentials match existing credentials', async () => {
        const { body } = await request(app).post("/api/status/login").send({ username: 'cloudUser', password: 'cloudIsC00l' }).expect(200)

        expect(body.msg).toBe('Authorisation successful')
      });
      test('POST /api/status/login - should respond with failure message if credentials do not match any existing credentials', async () => {
        const { body } = await request(app).post("/api/status/login").send({ username: 'notTheUser', password: 'notapassword' }).expect(400)
        expect(body.msg).toBe('Authorisation unsuccessful - credentials incorrect')
      });
      test('POST /api/status/login - should change loggedInUser', async () => {
        await request(app).post("/api/status/login").send({ username: 'cloudUser', password: 'cloudIsC00l' }).expect(200)

        expect(loggedInUser).toEqual({
          loggedIn: true, username: 'cloudUser'
        })
      });
    });
    describe('/api/status/register', () => {
      test('POST /api/status/register - should send new user credentials to authentication service an return a success message', async () => {
        const { body } = await request(app).post("/api/status/register").send({ username: 'anotherCloudUser', password: 'Cloud!Wow!' }).expect(200)

        expect(body.msg).toBe('Registration successful')
      });
      test('POST /api/status/register - should allow login with newly registered user', async () => {
        await request(app).post("/api/status/register").send({ username: 'yetAnotherCloudUser', password: 'cloudIsC00l' }).expect(200)

        const { body } = await request(app).post("/api/status/login").send({ username: 'yetAnotherCloudUser', password: 'cloudIsC00l' }).expect(200)
        expect(body.msg).toBe('Authorisation successful')
      });
      test('POST /api/status/register - should respond with failure message if credentials are not valid or already exist', async () => {
        const attemptOne = await request(app).post("/api/status/register").send({ username: 'cloudUser', password: 'cloudIsC00l' }).expect(400)
        expect(attemptOne.body.msg).toBe('Registration unsuccessful - username already exists')

        const attemptTwo = await request(app).post("/api/status/register").send({ username: 'notTheUser' }).expect(400)
        expect(attemptTwo.body.msg).toBe('Registration unsuccessful - credentials missing')

        const attemptThree = await request(app).post("/api/status/register").send({ password: 'cloudIsNotC00l' }).expect(400)
        expect(attemptThree.body.msg).toBe('Registration unsuccessful - credentials missing')
      });
    });
    describe('/api/status/logout', () => {
      test('POST /api/status/logout - should clear the login info from the memory', async () => {
        await request(app).post("/api/status/login").send({ username: 'cloudUser', password: 'cloudIsC00l' }).expect(200)
        const { body } = await request(app).post("/api/status/logout").send({}).expect(200)

        expect(body.msg).toBe('Logged out successfully')
        expect(loggedInUser).toEqual({
          loggedIn: false, username: null
        });
      });
    });
  });
});
