const request = require("supertest");
const app = require("../app");

describe("Heating Service", () => {
  test("GET /api/heating - should respond with the temperature ", async () => {
    const { body } = await request(app).get("/api/heating").expect(200);

    expect(body.temperature).toBeGreaterThan(0);
  });

  test("POST /api/heating - should update the heating", async () => {
    const newHeating = { temperature: 35 }; // oooh thats hot!
    const { body } = await request(app)
      .post("/api/heating")
      .send(newHeating)
      .expect(201);

    expect(body.temperature).toEqual(35);
  });
});

describe("Errors", () => {
  test("POST /api/heating - should return 400 if no temperature given", async () => {
    const response = await request(app).post("/api/heating").send({});
    expect(response.status).toBe(400);
    expect(response.body.msg).toBe("No temperature included");
  });
});
