require_relative '../ApiRTFetch'

namespace :api do

  a = ApiRTFetch.new

  desc "Run all API grabs"
  task all: [:get_upcoming_movies, :get_upcoming_dvds, :get_all_reviews]

  desc "Fetch RT API data and create theatrical release Movie instances"
  task get_upcoming_movies: :environment do
    puts "Grabbing upcoming movies..."
    a.get_upcoming_movies
    puts "DONE"
  end

  desc "Fetch RT API data and create upcoming DVD Movie instances"
  task get_upcoming_dvds: :environment do
    puts "Grabbing upcoming DVD releases..."
    a.get_upcoming_dvds
    puts "DONE"
  end

  desc "Fetch movie by name with title='query'"
  task get_movie_by_name: :environment do
    movie_name = ENV["title"]
    puts "Searching for '#{movie_name}'..."
    a.get_movie_by_name(movie_name)
    puts "DONE"
  end

  desc "Fetch RT API data and create Critic and CriticOpinion instances from fetched movie IDs"
  task get_all_reviews: :environment do
    puts "Getting reviews for #{Movie.all.length} movies..."
    puts "====>>>>====>>>>====>>>>====>>>>====>>>>"
    a.get_all_reviews
    puts "DONE"
  end

  desc "Fetch popular movies from popular_movies.yml lib seed file"
  task get_popular_movies: :environment do
    puts "Grabbing popular movies from 'popular_movies.yml'..."
    a.get_popular_movies
    puts "DONE"
  end

  desc "clears DB of all instances of movies, critics, and critic_opinions"
  task clear_db: :environment do
    ApiRTFetch.clear_db
    puts "DONE"
  end

end
