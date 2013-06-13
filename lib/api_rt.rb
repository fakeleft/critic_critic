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

  def get_response(query_string)
    uri = URI("#{@base_uri}" + query_string)
    response = Net::HTTP.get_response(uri)
    parse_response(response)
  end

  def parse_response(response)

    JSON.parse(response.body)
  end

  def seed_movies
    # Movie.create(title: "Hyde Park on Hudson", year: 2012, description: "Hyde Park on Hudson", rt_id: 771242341)

    get_upcoming_movies["movies"].each do |movie|
      title = movie["title"]
      year = movie["year"].to_s
      description =movie["synopsis"].
                            gsub(/[']/, "\\\\\'").
                              gsub(/["]/, "\\\\\"")
      rt_id =movie["id"]

      "Movie.create!(title: \"#{title}\", year: #{year}, description: \"#{description}\", rt_id: #{rt_id})"

    end
  end

  def seed_critics_and_reviews
    # freshness => like
    # [links][review] => url
    movie_ids = get_movie_ids
    movie_ids.each do |movie_id|
      critic_reviews = get_reviews(movie_id)
      critic_reviews["reviews"].each do |review|
        critic = review["critic"]
        review_url = review["links"]["review"]
        publication = review["publication"]
        like = review["freshness"]
        if like == "fresh"
          like = true
        else
          like = false
        end
        puts "Critic.create!(critic: \"#{critic}\", publication: \"#{publication}\")"
        puts "CriticOpinion.create!(like: \"#{like}\", url: \"#{review_url}\")"
      end
    end
  end

  def get_movie(movie_id)

    get_response("/movies/#{movie_id}.json?apikey=#{@api_key}")
  end

  def get_movie_ids
    new_releases = get_new_releases
    @movie_id_array = []
    new_releases["movies"].each do |movie|
      @movie_id_array << movie["id"]
    end
    return @movie_id_array
  end

  def search_movies(title, page_limit=10)

    get_response("/movies.json?apikey=#{@api_key}&q=#{title}&page_limit=#{page_limit}")
  end

  def get_new_releases(page_limit=10)
    base = "/lists/dvds/current_releases.json?apikey="
    number_of_records = "&page_limit=#{page_limit}"
    get_response(base + @api_key + number_of_records)
  end

  def get_reviews(movie_id, page_limit=10)

    get_response("/movies/#{movie_id}/reviews.json?apikey=#{@api_key}&page_limit=#{page_limit}")
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
end

test = ApiRT.new
# ap test.get_new_releases
# ap test.search_movies("jack")
ap test.get_movie(771242341)
# ap test.get_reviews(770672122)
# ap test.get_upcoming_movies
# puts test.get_upcoming_reviews
# ap test.seed_movies
#test.seed_critics_and_reviews
