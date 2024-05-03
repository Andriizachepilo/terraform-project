const request = require('supertest');
const app = require('../app');
const credentials = require("../credentials")


describe('User Auth Service', () => {
    describe('/api/auth/login', () => {
        describe('Auth Success', () => {
            test('POST /api/auth/login - should respond with success message if credentials match existing credentials', async () => {
                const { body } = await request(app).post("/api/auth/login").send({ username: 'cloudUser', password: 'cloudIsC00l' }).expect(200)
                expect(body.msg).toBe('Authorisation successful')
            });
        });
        describe('Auth Failure', () => {
            test('POST /api/auth/login - should respond with failure message if username does not match any existing credentials', async () => {
                const { body } = await request(app).post("/api/auth/login").send({ username: 'notTheUser', password: 'cloudIsC00l' }).expect(400)
                expect(body.msg).toBe('Authorisation unsuccessful - credentials incorrect')
            });
            test('POST /api/auth/login - should respond with failure message if password does not match any existing credentials', async () => {
                const { body } = await request(app).post("/api/auth/login").send({ username: 'cloudUser', password: 'cloudIsNotC00l' }).expect(400)
                expect(body.msg).toBe('Authorisation unsuccessful - credentials incorrect')
            });
        });
    });

    describe('/api/auth/register', () => {
        describe('Registration Success', () => {
            test('POST /api/auth/register - should respond with success message if credentials do not match existing credentials', async () => {
                const { body } = await request(app).post("/api/auth/register").send({ username: 'anotherCloudUser', password: 'Cloud!Wow!' }).expect(201)
                expect(body.msg).toBe('Registration successful')
            });
            test('POST /api/auth/register - should add given credentials to credentials object', async () => {
                await request(app).post("/api/auth/register").send({ username: 'anotherCloudUser2', password: 'Cloud!Wow!' }).expect(201)

                expect(credentials.hasOwnProperty('anotherCloudUser2')).toBe(true)
            });
            test('POST /api/auth/register - should allow login with newly registered user', async () => {
                await request(app).post("/api/auth/register").send({ username: 'yetAnotherCloudUser', password: 'cloudIsC00l' }).expect(201)

                const { body } = await request(app).post("/api/auth/login").send({ username: 'yetAnotherCloudUser', password: 'cloudIsC00l' }).expect(200)
                expect(body.msg).toBe('Authorisation successful')
            });
        });
        describe('Registration Failure', () => {
            test('POST /api/auth/register - should respond with failure message if no password given', async () => {
                const { body } = await request(app).post("/api/auth/register").send({ username: 'notTheUser' }).expect(400)
                expect(body.msg).toBe('Registration unsuccessful - credentials missing')
            });
            test('POST /api/auth/register - should respond with failure message if no username given', async () => {
                const { body } = await request(app).post("/api/auth/register").send({ password: 'cloudIsNotC00l' }).expect(400)
                expect(body.msg).toBe('Registration unsuccessful - credentials missing')
            });
            test('POST /api/auth/register - should respond with failure message if username given already exists', async () => {
                const { body } = await request(app).post("/api/auth/register").send({ username: 'cloudUser', password: 'cloudIsC00l' }).expect(400)
                expect(body.msg).toBe('Registration unsuccessful - username already exists')
            });
        });
    });
});
