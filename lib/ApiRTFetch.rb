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
######################################################################

class ApiRTFetch

  attr_reader :movie_ids

  def initialize
    @base_uri = 'http://api.rottentomatoes.com/api/public/v1.0'
    @api_key = YAML::load(File.open("lib/api_key.yml"))
    @movie_ids = []

    @movie_count = 10
    @review_count = 10
  end

  def self.clear_db
    # clears the current database of all entries
    puts "Deleting DB Movie instances..."
    Movie.delete_all
    puts "Deleting DB Critic instances..."
    Critic.delete_all
    puts "Deleting DB CriticOpinion instances..."
    CriticOpinion.delete_all
    puts "DONE"
  end

  def get_response(query_string)
    uri = URI("#{@base_uri}" + query_string)
    response = Net::HTTP.get_response(uri)
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
      m.release_date = movie["release_dates"]["theater"]
      m.image_url = movie["posters"]["detailed"]
      m.save
      # builds array of rt_ids for review fetching
      @movie_ids << movie["id"]
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
      # builds array of rt_ids for review fetching
      @movie_ids << movie["id"]
    end
  end

  def get_movie_by_name(title)
    response = get_response("/movies.json?apikey=#{@api_key}&q=#{title}&page_limit=#{@movie_count}")

    movie_query = response["movie"][0]

    m = Movie.new
    m.title = movie_query["title"]
    m.year = movie_query["year"]
    m.descriptoin = movie_query["synopsis"]
    m.rt_id = movie_query["id"].to_i
    m.release_date = movie_query["release_dates"]["theater"]
    m.image_url = movie_query["posters"]["detailed"]
    m.save

    # builds array of rt_ids for review fetching
    @movie_ids << movie["id"]
  end

  def get_all_reviews
    puts "getting #{@movie_ids.length} movie reviews"
    @movie_ids.each do |id|
      get_reviews_by_id(id)
    end
  end

  def get_reviews_by_id(movie_rt_id)
    # grabs each review-set by rt_id
    reviews_by_id = get_response("/movies/#{movie_rt_id}/reviews.json?apikey=#{@api_key}&page_limit=#{@review_count}")

    reviews_by_id["reviews"].each do |review|
      # inits new critic_opinion instance called 'co' & sets attrs
      co = CriticOpinion.new
      review["freshness"] == 'fresh'? co.like = true : co.like = false
      co.url = review["links"]["review"]
      co.critic = Critic.find_or_create_by_name_and_publication(review["critic"], review["publication"])
      co.movie = Movie.find_by_rt_id(movie_rt_id)
      co.save
    end
  end
end

