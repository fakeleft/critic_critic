require './api_seed_generator'

popular_movies = ["Iron Man 3",
  "Oz the Great and Powerful",
  "Fast Furious 6",
  "Star Trek Into Darkness",
  "The Croods",
  "Man of Steel",
  "The Great Gatsby",
  "Identity Thief",
  "GI Joe Retaliation",
  "The Hangover Part 3",
  "Olympus Has Fallen",
  "Epic",
  "42",
  "Oblivion",
  "Now You See Me",
  "Mama",
  "Safe Haven",
  "A Good Day To Die Hard",
  "Warm Bodies",
  "Jack The Giant Slayer"]
 # popular_movies = ["A Good Day To Die Hard"]

 test = ApiSeedGenerator.new
 movies = []
 popular_movies.each { |movie| movies << test.search_movies(movie)}
 # puts movies
 # puts popular_movies
 # movies = test.get_upcoming_movies
 puts test.seed_movies(movies)
 puts test.seed_reviews(movies)
 # puts test.seed_upcoming_movies
 # test.seed_critics_and_reviews
# puts test.get_movie_reviews(10104).first.to_seed_string
