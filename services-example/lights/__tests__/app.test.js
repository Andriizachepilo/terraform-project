const request = require("supertest");
const app = require("../app");

describe("Lights Service", () => {
  test("GET /api/lights - should respond with an array of light objects ", async () => {
    const { body } = await request(app).get("/api/lights").expect(200);

    expect(body.lights.length).toBeGreaterThan(0);
    body.lights.forEach((light) => {
      expect(light).toEqual(
        expect.objectContaining({
          location: expect.any(String),
          status: expect.any(Boolean),
        })
      );
    });
  });

  test("POST /api/lights - should allow a new light to be added with status as false as default", async () => {
    const newLight = { location: "Kitchen" };
    const { body } = await request(app)
      .post("/api/lights")
      .send(newLight)
      .expect(201);

    expect(body.light).toEqual({ id: 1, ...newLight, status: false });
  });

  test("POST /api/lights/switch - should allow to swap the boolean status for a light with each id", async () => {
    const light = { id: 0 };
    const { body } = await request(app)
      .post("/api/lights/switch")
      .send(light)
      .expect(202);

    expect(body.light).toEqual({
      id: 0,
      location: "Living Room",
      status: true,
    });
  });
});

describe("Errors", () => {
  test("POST /api/lights - should return 400 if no location given", async () => {
    const response = await request(app).post("/api/lights").send({});
    expect(response.status).toBe(400);
    expect(response.body.msg).toBe("No location included");
  });

  test("POST /api/lights/switch - should return 400 if no id given", async () => {
    const response = await request(app).post("/api/lights/switch").send({});
    expect(response.status).toBe(400);
    expect(response.body.msg).toBe("No ID included");
  });
  test("POST /api/lights/switch - should return 400 if id given is not a number", async () => {
    const response = await request(app)
      .post("/api/lights/switch")
      .send({ id: "0" });
    expect(response.status).toBe(400);
    expect(response.body.msg).toBe("ID must be an integer");
  });
  test("POST /api/lights/switch - should return 404 if ID doesn't exist ", async () => {
    const response = await request(app)
      .post("/api/lights/switch")
      .send({ id: 10 });
    expect(response.status).toBe(404);
    expect(response.body.msg).toBe("ID not found");
  });
});
