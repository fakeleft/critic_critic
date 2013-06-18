require './api_seed_generator'

 test = ApiSeedGenerator.new
 movies = test.get_upcoming_movies
 puts test.seed_movies(movies)
 puts test.seed_reviews(movies)
 # puts test.seed_upcoming_movies
 # test.seed_critics_and_reviews
# puts test.get_movie_reviews(10104).first.to_seed_string
