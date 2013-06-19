# require 'ap'
require 'uri'
require 'json'
require 'net/http'
require 'yaml'

# movie structure
RtMovie = Struct.new(:title, :year, :synopsis, :rt_id) do
  def escaped_synopsis
    synopsis.gsub(/[']/, "\\\\\'").
      gsub(/["]/, "\\\\\"")
  end

  def to_seed_string
    "Movie.create!(title: \"#{title}\", year: #{year.to_s}, description: \"#{escaped_synopsis}\", rt_id: #{rt_id})"
  end
end

RtCritic = Struct.new(:name, :publication) do
  def to_seed_string
    "c = Critic.create!(name: \"#{name}\", publication: \"#{publication}\")"
  end
end

RtReview = Struct.new(:rt_id, :like, :review_url, :critic) do
  def to_seed_string
    if (critic.name.length > 0) #Don't try to seed reviews without a valid critic name.
      seed_string = critic.to_seed_string
      seed_string << "\nm = Movie.find_by_rt_id(#{rt_id})\n" +
      "CriticOpinion.create!(like: \"#{like}\", url: \"#{review_url}\", critic: c, movie: m)"
    end
  end
end

class ApiSeedGenerator

  attr_accessor :api_key

  def initialize
    @base_uri = 'http://api.rottentomatoes.com/api/public/v1.0'
    set_api_key
  end

  def set_api_key
    #Running without rails.
    if File.exists?('api_key.yml')
      @api_key = YAML::load(File.open('api_key.yml'))
    else
      #Running in rails.
      @api_key = YAML::load(File.open(File.join(Rails.root , 'lib', 'api_key.yml'), "r"))
    end
  end

  def get_response(query_string)
    escaped_query = URI.escape(query_string)
    uri = URI("#{@base_uri}" + escaped_query)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def seed_movies(movies)
    movies.map { |movie| movie.to_seed_string }
  end

  def seed_reviews(movies)
    get_reviews_for_movies(movies).map { |review| review.to_seed_string }
  end

  def get_movie(movie_id)
    response = get_response("/movies/#{movie_id}.json?apikey=#{@api_key}")
    parse_movie(response)
  end

  def get_movie_ids(movies)
    movies.map { |movie| movie.rt_id }
  end

  # def get_new_releases(page_limit=10)
  #   base = "/lists/dvds/current_releases.json?apikey="
  #   number_of_records = "&page_limit=#{page_limit}"
  #   get_response(base + @api_key + number_of_records)
  # end

#get reviews for movies
  def get_upcoming_reviews(page_limit=10)
    movies_json = get_upcoming_movies
    movie_ids = []
    movies_json["movies"].each do |movie|
      movie_ids << movie["id"]
    end
    movie_reviews = []
    movie_ids.each do |movie|
      # this is broken
      # if movie["total"] > 1
        movie_reviews << get_reviews(movie)
      # end
    end
    movie_reviews
  end

# the following code is in a state of refactor using Struct classes

  def search_movies(title, page_limit=1)
    response = get_response("/movies.json?apikey=#{@api_key}&q=#{title}&page_limit=#{page_limit}")
    RtMovie.new(
      response["movies"][0]["title"],
      response["movies"][0]["year"],
      response["movies"][0]["synopsis"],
      response["movies"][0]["id"].to_i
      )
  end

  def get_reviews_for_movies(movies)
    reviews = []
    movie_ids = get_movie_ids(movies)
    movie_ids.each do |movie_id|
      reviews.concat(get_movie_reviews(movie_id))
    end
    reviews
  end

  def get_movie_reviews(rt_id, page_limit=10)
    response = get_response("/movies/#{rt_id}/reviews.json?apikey=#{@api_key}&page_limit=#{page_limit}")
    reviews = []
    response['reviews'].each do |review|
      reviews << parse_review(review, rt_id)
    end
    reviews
  end

  def parse_movie(movie)
    movie = RtMovie.new(movie["title"],
      movie["year"],
      movie["synopsis"],
      movie["id"].to_i)
  end

  def parse_review(review, rt_id)
    critic = RtCritic.new(
        review["critic"],
        review["publication"]
        )
    RtReview.new(
      rt_id,
      (review["freshness"] == "fresh"),
      review["links"]["review"],
      critic
      )
    # puts review
  end

  def get_upcoming_movies(page_limit=10)
    response = get_response("/lists/movies/upcoming.json?apikey=#{@api_key}&page_limit=#{page_limit}")
    upcoming_movies = []
    response['movies'].each do |movie|
      upcoming_movies << parse_movie(movie)
    end
    upcoming_movies
  end
end
