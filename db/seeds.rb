# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# make questions
questions = Question.create([
	{ question: "What is the capital of France?", ansA: "Paris", ansB: "Lyon", ansC: "Marseille", ansD: "Toulouse", points: rand(2)+1 },
	{ question: "What is the capital of Spain?", ansA: "Madrid", ansB: "Barcelona", ansC: "Valencia", ansD: "Seville", points: rand(2)+1 },
	{ question: "What is the capital of Italy?", ansA: "Rome", ansB: "Milan", ansC: "Naples", ansD: "Turin", points: rand(2)+1 },
	{ question: "What is the capital of Germany?", ansA: "Berlin", ansB: "Munich", ansC: "Hamburg", ansD: "Frankfurt", points: rand(2)+1 },
	{ question: "What is the capital of Belgium?", ansA: "Brussels", ansB: "Antwerp", ansC: "Ghent", ansD: "Charleroi", points: rand(2)+1 },
	{ question: "What is the capital of Switzerland?", ansA: "Bern", ansB: "Zurich", ansC: "Geneva", ansD: "Lausanne", points: rand(2)+1 },
	{ question: "What is the capital of Austria?", ansA: "Vienna", ansB: "Salzburg", ansC: "Linz", ansD: "Innsbruck", points: rand(2)+1 },
	{ question: "What is the capital of Portugal?", ansA: "Lisbon", ansB: "Porto", ansC: "Faro", ansD: "Coimbra", points: rand(2)+1 },
])

teams = Team.create([
	{ name: "Huslers", quantity: 5 },
	{ name: "Iconic", quantity: 6 },
	{ name: "Penguins", quantity: 7 },
	{ name: "Cats", quantity: 8 },
	{ name: "Dogs", quantity: 9 },
])

rules = Rule.create([
	{ content: "The team that answers the question first is the winner.", orderID: 1 },
	{ content: "You have to answer the question within the time limit.", orderID: 2 },
	{ content: "You can't use the same answer more than once.", orderID: 3 },
])
