# Node.js, Express.js, Sequelize.js and PostgreSQL RESTful API

This source code is part of [Node.js, Express.js, Sequelize.js and PostgreSQL RESTful API](https://www.djamware.com/post/5b56a6cc80aca707dd4f65a9/nodejs-expressjs-sequelizejs-and-postgresql-restful-api) tutorial.

To run locally:

* Make sure you have install and run PostgreSQL server
* Create database with the name same as in config file
* Run `npm install` or `yarn install`
* Run `sequelize db:migrate`
* Run `nodemon` or `npm start`


npm install
npm install -g sequelize-cli
sequelize db:migrate

curl -i -X POST -H "Content-Type: application/json" -d "{ \"class_name\":\"Class A\",\"students\": [{ \"student_name\":\"John Doe\" },{ \"student_name\":\"Jane Doe\" },{ \"student_name\":\"Doe Doel\" }] }" localhost:3000/api/classroom/add_with_students

curl -i -X POST -H "Content-Type: application/json" -d "{ \"lecturer_name\":\"Kylian Mbappe\",\"course\": { \"course_name\":\"English Grammar\" } }" http://localhost:3000/api/lecturer/add_with_course

curl -i -X POST -H "Content-Type: application/json" -d "{ \"student_id\":1,\"course_id\": 1}" localhost:3000/api/student/add_course