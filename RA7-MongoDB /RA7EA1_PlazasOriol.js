//EX 1
/*
mongoimport --db itb --collection people --drop --type json --file C:\Users\Oriol\Descargas\people.json --jsonArray
mongoimport --db itb --drop --type csv --headerline --file C:\Users\Oriol\Downloads\students.csv
mongoimport --db itb --collection products --drop --file C:\Users\Oriol\Downloads\products.json
*/

//EX 2.1
use catalogo
db.productos.insertOne({"name": "MacBook Pro"})
db.productos.insertOne({"name": "MacBook Air"})
db.productos.insertOne({"name": "MacBook"})
show dbs
show collections
exit
mongo catalogo

//EX 2.2
mongo catalogo
db.productos.find()
db.productos.find({"name": "MacBook Air"})

//EX 2.3
mongo catalogo
var cursor = db.productos.find()
//veure si hi ha un document
cursor.hasNext()
//iterar document
cursor.next()

//EX 2.4
mongo catalogo
db.productos.insertMany([{ "name": "iPhone 8" }, { "name": "iPhone 6s" }, { "name": "iPhone X" }, { "name": "iPhone SE" }, { "name": "iPhone 7" }]);
db.productos.find()
db.productos.find({"name":"iPhone 7"})
db.productos.find({"name":"MacBook"})

//EX 2.5
mongo catalogo
db.productos.drop()
db.dropDatabase()
db.products.insertMany([{ "name": "iPhone 8" }, { "name": "MacBook Pro" }, { "name": "iPhone 6s" }, { "name": "MacBook Air" }, { "name": "iPhone X" }, { "name": "iPhone SE" }, { "name": "MacBook" }, { "name": "iPhone 7" }]);
db.productos.find({"name":"iPhone 8"})

//EX 2.6
mongoimport --db catalogo --collection productos --drop --file C:\Users\Oriol\Downloads\products.json
db.productos.find()
db.productos.find().pretty()
db.productos.find({"price": 329})
db.productos.find("stock": 100)
db.productos.find({"name":"Apple Watch Nike+"})

//EX 2.7
mongo catalogo
db.productos.find({"name": 1, "price" : 1})
db.productos.find({"categories": ["macbook", "notebook"]})
db.productos.find({"categories": "watch"})

//EX 2.8
mongo catalogo
db.productos.find({"price": 2399}, {"name": 1})
db.productos.find({"categories": "iphone"}, {"stock": 0, "picture": 0})
//ocultant _id
db.productos.find({"price": 2399}, {"name": 1, "_id": 0})
db.productos.find({"categories": "iphone"}, {"stock": 0, "picture": 0, "_id": 0})

//EX 2.9
mongo catalogo
db.productos.find({"price": {$gt: 2000}})
db.productos.find({"price": {$lt: 500}})
db.productos.find({"price": {$lte: 500}})
db.productos.find({"price": {$lte: 1000, $gte: 500}})
db.productos.find({"price": {$in: [399, 699, 1299]}})

//EX 2.10
mongo catalogo
db.productos.find({$and: [{"stock": 200}, {"categories": "iphone"}]})
db.productos.find({$or: [{"price": 329}, {"categories": "tv"}]})

//EX 2.11
mongo catalogo
db.productos.updateOne({"name": "Mac mini"}, {$set: {"stock": 50}})
db.productos.updateOne({"name": "iPhone X"}, {$set: {"prime": true}})
db.productos.find({"name":  {$in: ["Mac mini", "iPhone X"] }}, {"stock": 0, "categories": 0, "_id": 0}).pretty()

//EX 2.12
mongo catalogo
db.productos.updateOne({"name": "iPad Pro"}, {$push: {"categories": "prime"}})
db.productos.updateOne({"name": "iPad Pro"}, {$pop: {"categories": 1}})
db.productos.updateOne({"name": "iPhone SE"}, {$pop: {"categories": -1}})
db.productos.updateMany({"price" : {$gt: 2000}}, {$push: {"categories": "expensive"}})

//EX 2.13
mongo catalogo
db.productos.deleteOne({"categories": "tv"})
db.productos.deleteOne({"name": "Apple Watch Series 1"})
db.productos.find({"name": "Mac mini"}, {"_id": 1})
db.productos.find({ "_id" : ObjectId("6a00b06215f4c45ed883cc02") })

//EX 2.14
mongoimport --db catalogo --collection productos --drop --file C:\Users\Oriol\Downloads\products.json
mongo catalogo
db.productos.find()

//EX 2.15
mongo catalogo
db.productos.find({}).sort({price: 1})
db.productos.find({}).sort({price: -1})
db.productos.find({}).sort({stock: 1})
db.productos.find({}).sort({stock: -1})
db.productos.find({}).sort({name: 1})
db.productos.find({}).sort({name: -1})

//EX 2.16
mongo catalogo
db.productos.find({}, {name: 1}).limit(2)
db.productos.find({}, {name: 1}).sort({name: 1}).limit(5)
db.productos.find({}, {name: 1}).sort({name: -1}).limit(5)

//EX 2.17
mongo catalogo
db.productos.find().skip(0).limit(5).pretty();