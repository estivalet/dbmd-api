### Add a new system

```bash
curl -i -X POST -H "Content-Type: application/json" -d "{ \"name\":\"Atari 2600\"}" localhost:3000/system
```

Expected output:

```bash
HTTP/1.1 201 Created
X-Powered-By: Express
Content-Type: application/json; charset=utf-8
Content-Length: 151
ETag: W/"97-OJZ3tEZ9xC2JhDc8NR7pHzqb+hU"
Date: Wed, 22 May 2019 17:24:50 GMT
Connection: keep-alive

{"games":[],"_id":"5ce585e247fdafba88e21b8d","name":"Atari 2600","createdAt":"2019-05-22T17:24:50.444Z","updatedAt":"2019-05-22T17:24:50.444Z","__v":0}
```

### Add a new game

```bash
curl -i -X POST -H "Content-Type: application/json" -d "{ \"system\":\"5ce585e247fdafba88e21b8d\",\"title\":\"Enduro\", \"year\":\"1980\", \"tags\":[\"USA\"]}" localhost:3000/game
```

Expected output:

```bash
"tags\":[\"USA\"]}" localhost:3000/game
HTTP/1.1 201 Created
X-Powered-By: Express
Content-Type: application/json; charset=utf-8
Content-Length: 202
ETag: W/"ca-G/+mbI6/NXOEKMpyf4hgX6ygPPw"
Date: Wed, 22 May 2019 17:39:27 GMT
Connection: keep-alive

{"tags":["USA"],"_id":"5ce5894f47fdafba88e21b8e","title":"Enduro","year":"1980","system":"5ce585e247fdafba88e21b8d","createdAt":"2019-05-22T17:39:27.639Z","updatedAt":"2019-05-22T17:39:27.639Z","__v":0}
```

### Retrieve a system

#### Using curl

```bash
curl -i -X GET localhost:3000/systems
```

Expected output:

```bash
HTTP/1.1 200 OK
X-Powered-By: Express
Content-Type: application/json; charset=utf-8
Content-Length: 179
ETag: W/"b3-Z8X/+3nIViyF7gYzRcCZt3VFMow"
Date: Wed, 22 May 2019 17:42:10 GMT
Connection: keep-alive

[{"games":["5ce5894f47fdafba88e21b8e"],"_id":"5ce585e247fdafba88e21b8d","name":"Atari 2600","createdAt":"2019-05-22T17:24:50.444Z","updatedAt":"2019-05-22T17:39:27.660Z","__v":0}]
```

#### Using mongo client

Enter in mongo client and type mongo:

```console
cd mongodb-3.6\bin
mongo
```

Inside mongo client type:

```console
show dbs;
use octupusgdb-api;
show collections;
db.systems.find();
```