#
# belongs to critic_critic
#
# usage:
#  * 2 God-Functions to be called in order: "get_upcoming_movies" and "get_all_reviews"
#
#  * get_response - takes query string, fetches w/ api_key, returns parsed hash
#  * get_upcoming_movies - creates movie objs and builds rt_ids array
#  * get_all_reviews - takes array of rt_ids & passes each to get_reviews_by_id
#  * get_reviews_by_id - takes an rt_id to fetch reviews, create CriticOpinion objs and Critic objs
######################################################################

class ApiRTFetch

  def initialize
    @base_uri = 'http://api.rottentomatoes.com/api/public/v1.0'
    @api_key = YAML::load(File.open("lib/api_key.yml"))

    # MUST BE BELOW api-limit of 10-per-sec
    @movie_count = 10
    @review_count = 10
    @upcoming_movie_ids = []
  end

  def self.clear_db
    # clears the current database of all entries
    Movie.delete_all
    Critic.delete_all
    CriticOpinion.delete_all
  end

  def get_response(query_string)
    uri = URI("#{@base_uri}" + query_string)
    response = Net::HTTP.get_response(uri)
    return JSON.parse(response.body)
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
      m.save
      # builds array of rt_ids for review fetching
      @upcoming_movie_ids << movie["id"]
    end
  end

  def get_all_reviews
    @upcoming_movie_ids.each do |id|
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

