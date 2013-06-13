require 'ap'
require 'uri'
require 'json'
require 'net/http'
require 'yaml'

class ApiRT
  def initialize
    @base_uri = 'http://api.rottentomatoes.com/api/public/v1.0'
    # config_hash = YAML::load_file("/path/to/your/config.yaml")
    # lets find a new way to store this environment variable perhaps?
    @api_key = YAML::load(File.open("rt_api.yml"))
  end
  def get_movie(movie_id)
    get_response("/movies/#{movie_id}.json?apikey=#{@api_key}")
  end
  def search_movies(title, page_limit=10)
    get_response("/movies.json?apikey=#{@api_key}&q=#{title}&page_limit=#{page_limit}")
  end
  def get_response(query_string)
    uri = URI("#{@base_uri}" + query_string)
    response = Net::HTTP.get_response(uri)
    parse_response(response)
  end
  def get_new_releases(page_limit=10)
    base = "/lists/dvds/current_releases.json?apikey="
    number_of_records = "&page_limit=#{page_limit}"
    get_response(base + @api_key + number_of_records)
  end
  def get_reviews(movie_id)
    get_response("/movies/#{movie_id}/reviews.json?apikey=#{@api_key}")
  end
  def get_upcoming_movies(page_limit=10)
    get_response("/lists/movies/upcoming.json?apikey=#{@api_key}&page_limit=#{page_limit}")
  end
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
  def parse_response(response)
    JSON.parse(response.body)
  end
end

test = ApiRT.new
# ap test.get_new_releases
# ap test.search_movies("jack")
# ap test.get_movie(770672122)
# ap test.get_reviews(770672122)
# ap test.get_upcoming_movies
puts test.get_upcoming_reviews
