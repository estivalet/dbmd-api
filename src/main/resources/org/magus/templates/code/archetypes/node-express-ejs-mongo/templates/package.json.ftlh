{
  "name": "${app.shortName}-server",
  "version": "0.0.0",
  "private": true,
  "scripts": {
    "start": "node app.js",
    "devstart": "nodemon app.js"
  },
  "dependencies": {
    "async": "^2.6.1",
    "body-parser": "1.7.0",
    "cookie-parser": "~1.4.3",
    "csv": "^3.1.0",
    "debug": "~2.6.9",
    "ejs": "^2.5.8",
    "express": "~4.16.0",
    "jsonwebtoken": "^7.3.0",
    "http-errors": "~1.6.2",
    "moment": "^2.17.1",
    "moment-timezone": "^0.5.13",
    "mongoose": "^5.0.14",
    "morgan": "~1.9.0",
    "node-uuid": "^1.4.8",
    "npm": "^6.4.1",
    "pug": "2.0.0-beta11",
    "request": "^2.88.0",
    "ssh2-sftp-client": "^2.2.1",
    "swagger-ui-express": "^2.0.13",
    "sync-request": "^4.0.2"
  },
  "devDependencies": {
    "nodemon": "^1.17.3"
  }
}