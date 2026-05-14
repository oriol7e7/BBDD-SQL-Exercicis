/*
1. Inserció de dades. Inserta els següents documents dins la col·lecció “movieDetails”.
*/
db.movieDetails.insertOne({
  title: "Fight Club",
  writer: "Chuck Palahniuk",
  year: 1999,
  actors: ["Brad Pitt", "Edward Norton"]
})
db.movieDetails.insertOne({
  title: "Pulp Fiction",
  writer: "Quentin Tarantino",
  year: 1994,
  actors: ["John Travolta", "Uma Thurman"]
})
db.movieDetails.insertOne({
  title: "Inglorious Bastards",
  writer: "Quentin Tarantino",
  year: 2009,
  actors: ["Brad Pitt", "Diane Kruger", "Eli Roth"]
})
db.movieDetails.insertOne({
  title: "The Hobbit: The Desolation of Smaug",
  writer: "J.R.R. Tolkein",
  year: 2013
})
db.movieDetails.insertOne({
  title: "The Hobbit: The Battle of the Five Armies",
  writer: "J.R.R. Tolkein",
  year: 2012,
  synopsis: "Bilbo, Gandalf and Company are forced to engage in a war against an array of combatants and keep the Lonely Mountain from falling into the hands of a rising darkness."
})
db.movieDetails.insertOne({
  title: "The Shawshank Redemption",
  writer: "Stephen King",
  year: 1994,
  actors: ["Tim Robbins", "Morgan Freeman", "Bob Gunton"],
  synopsis: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency."
})
db.movieDetails.insertOne({
  title: "Avatar",
  writer: "James Cameron",
  year: 2009,
  actors: ["Sam Worthington", "Zoe Saldana", "Sigourney Weaver"],
  synopsis: "A paraplegic marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home."
})

/*
2. Consulta de dades. Cerca dins de la col·lecció “movieDetails”.
*/
db.movieDetails.find();
db.movieDetails.find({writers: 'Quentin Tarantino'});
db.movieDetails.find({actors: 'Brad Pitt'});
db.movieDetails.find({genres: {$all: ['Action', 'Western']}});
db.movieDetails.find({year: {$gte: 1990, $lte: 1999}});
db.movieDetails.find({$or: [{year: {$lt: 2000}}, {year: {$gt: 2010}}]});
db.movieDetails.find({countries: 'Spain'});
db.movieDetails.find({"awards.wins": {$gt: 100}})
db.movieDetails.find({writers: {$size: 10}})

/*
3. Consulta de dades utilitzant expressions regulars a la col·lecció “movieDetails”.
*/
db.movieDetails.find({synopsis: {$exists: true}}, {_id: 1, synopsis: 1})
db.movieDetails.find({synopsis: /Bilbo/}, {title: 1, synopsis: 1, _id: 0})
db.movieDetails.find({synopsis: {$exists: true, $not: /Bilbo/}}, {title: 1, synopsis: 1, _id: 0})
db.movieDetails.countDocuments({plot: {$in: [/dwarves/, /hobbit/]}})
db.movieDetails.find({title: {$all: [/Battle/, /Armies/]}})
db.movieDetails.find({directors: /^Don/}, {title: 1, directors: 1, _id: 0})
db.movieDetails.find({"awards.text": /ins\.$/}, {title: 1, awards: 1, _id: 0})

/*
4. Actualització de Documents dins de la col·lecció “movieDetails”. Comprova els canvis amb un
find().
*/
db.movieDetails.updateOne({title: 'The Hobbit: An Unexpected Journey'}, {$set: {synopsis: 'A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home - and the gold within it - from the dragon Smaug.'}})
db.movieDetails.updateOne({title: 'Pulp Fiction'},{$push: {actors: 'Samuel L. Jackson'}});
db.movieDetails.updateMany({}, {$unset: {type: ""}})
db.movieDetails.updateOne({title: "The World Is Not Enough"}, {$set: {"writers.4": "Bruce Harris"}})
db.movieDetails.updateOne({title: "Whisper of the Heart"}, {$pop: {genres: 1}})

/*
5. Eliminar Documents de la col·lecció “movieDetails”.
*/
db.movieDetails.deleteOne({title: /Star Trek/})
db.movieDetails.deleteOne({title: 'Love Actually'});
db.movieDetails.deleteOne({rated: 'G'});
db.movieDetails.deleteMany({genres: 'Western'});
db.movieDetails.deleteMany({"awards.wins": 0});

