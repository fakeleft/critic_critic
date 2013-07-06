#
# belongs to critic_critic
#
# usage:
#  * 3 God-Functions to be called in order: "get_upcoming_movies" or
#    "get_upcoming_dvds" then "get_all_reviews"
#
#  * get_response - takes query string, fetches w/ api_key, returns parsed hash
#  * get_upcoming_movies - creates movie objs and builds rt_ids array
#  * get_upcoming_dvds   - creates movie objs and builds rt_ids array
#  * get_all_reviews - takes array of rt_ids & passes each to get_reviews_by_id
#  * get_reviews_by_id - takes 1 rt_id to fetch reviews, then
#    creates CriticOpinion objs and Critic objs.
#  * get_movie_by_name = takes query title, fetches individual movie
######################################################################

class ApiRTFetch

  BASE_URI = 'http://api.rottentomatoes.com/api/public/v1.0'

  def initialize
    @api_key = YAML::load(File.open("lib/api_key.yml"))
    @popular_movies = YAML::load(File.open("lib/popular_movies.yml"))

    @movie_count = 30
    @review_count = 30
  end

  def self.clear_db
    # clears the current database of all entries
    puts "Deleting DB Movie instances..."
    Movie.delete_all
    puts "Deleting DB Critic instances..."
    Critic.delete_all
    puts "Deleting DB CriticOpinion instances..."
    CriticOpinion.delete_all
  end

  def get_response(query_string)
    uri = URI::escape(BASE_URI + query_string)
    url = URI(uri)
    response = Net::HTTP.get_response(url)
    return JSON.parse(response.body)
  end

  def get_upcoming_dvds
    upcoming_dvds = get_response("/lists/dvds/upcoming.json?apikey=#{@api_key}&page_limit=#{@movie_count}")

    # creates each movie instance
    upcoming_dvds["movies"].each do |movie|
      m = Movie.new
      m.rt_id = movie["id"]
      m.title = movie["title"]
      m.description = movie["synopsis"]
      m.year = movie["year"]
      m.release_date = movie["release_dates"]["theater"].to_s
      m.image_url = movie["posters"]["detailed"]
      m.save
    end
  end

  def get_upcoming_movies
    upcoming_movies = get_response("/lists/movies/upcoming.json?apikey=#{@api_key}&page_limit=#{@movie_count}")

    # creates each movie instance
    upcoming_movies["movies"].each do |movie|
      m = Movie.new
      m.rt_id = movie["id"]
      m.title = movie["title"]
      m.description = movie["synopsis"]
      m.year = movie["year"]
      m.release_date = movie["release_dates"]["theater"].to_s
      m.image_url = movie["posters"]["detailed"]
      m.save
    end
  end

  def get_popular_movies
    @popular_movies.each do |movie_title|
      get_movie_by_name(movie_title)
    end
  end

  def get_movie_by_name(title)
    response = get_response("/movies.json?apikey=#{@api_key}&q=#{title}&page_limit=2")

    movie = response["movies"][0] # just save first result
    m = Movie.new
    m.title = movie["title"]
    m.year = movie["year"]
    m.description = movie["synopsis"]
    m.rt_id = movie["id"].to_i
    m.release_date = movie["release_dates"]["theater"].to_s
    m.image_url = movie["posters"]["detailed"]
    m.save
  end

  def get_all_reviews
    Movie.all.each do |db_movie|
      puts "=> Getting reviews for '#{db_movie.title}'..."
      get_reviews_by_id(db_movie.rt_id)
    end
  end

  def get_reviews_by_id(movie_rt_id)
    response = get_response("/movies/#{movie_rt_id}/reviews.json?apikey=#{@api_key}&page_limit=#{@review_count}")

    response["reviews"].each do |review|
      co = CriticOpinion.new
      review["freshness"] == 'fresh'? co.like = true : co.like = false
      co.url = review["links"]["review"]
      co.critic = Critic.find_or_create_by_name_and_publication(review["critic"], review["publication"])
      co.movie = Movie.find_by_rt_id(movie_rt_id)
      co.save
    end
  end
end

