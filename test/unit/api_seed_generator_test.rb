require 'test_helper'
require 'api_seed_generator'

describe 'ApiSeedGenerator' do
  before do
    @seed_generator = ApiSeedGenerator.new
  end

  it 'should get an api key' do
    @seed_generator.api_key.class.must_equal String
  end
  it 'should get the details for one movie by title' do
    movie = @seed_generator.search_movies("Fried&Green&Tomatoes", 1)
    movie.title.must_equal "Fried Green Tomatoes"
  end

  it 'should get the reviews for one movie by id' do
    reviews = @seed_generator.get_movie_reviews(10104)
    reviews.first.like.wont_be_nil
  end
  it 'should return the movie ids from a collection of movies' do
    movies = @seed_generator.get_upcoming_movies
    movie_ids = @seed_generator.get_movie_ids(movies)
    movie_ids.empty?.must_equal false
    movie_ids.first.class.must_equal Fixnum
  end

  # these tests are driving the refactor


  it 'should return a single RtMovie' do
    movie = @seed_generator.search_movies("Fried&Green&Tomatoes", 1)
    movie.class.must_equal RtMovie
    movie.title.must_equal "Fried Green Tomatoes"
    movie.year.must_equal 1991
    movie.rt_id.must_equal 10104
    movie.synopsis.must_equal ""
    movie.to_seed_string.must_equal "Movie.create!(title: \"Fried Green Tomatoes\", year: 1991, description: \"\", rt_id: 10104)"
  end

  it 'should return an array of MovieReviews' do
    reviews = @seed_generator.get_movie_reviews(10104)
    reviews.class.must_equal Array
    this_review = reviews[0]
    this_review.class.must_equal RtReview
    this_review.like.must_equal true
    this_review.rt_id.must_equal 10104
    this_review.review_url.must_equal "http://www.ew.com/ew/article/0,,309135,00.html"
    this_review.critic.name.must_equal "Owen Gleiberman"
    this_review.critic.publication.must_equal "Entertainment Weekly"
  end

  it 'should return the seed string for a movie' do
    movie = @seed_generator.search_movies("Laurence&Anyways", 1)
    movie.to_seed_string.must_equal 'Movie.create!(title: "Laurence Anyways", year: 2012, description: "Laurence Anyways clip", rt_id: 771303201)'
  end

  it 'should return the seed string for a review' do
    review_string = %Q|c = Critic.create!(name: "Owen Gleiberman", publication: "Entertainment Weekly")
m = Movie.find_by_rt_id(10104)
CriticOpinion.create!(like: "true", url: "http://www.ew.com/ew/article/0,,309135,00.html", critic: c, movie: m)|

    reviews = @seed_generator.get_movie_reviews(10104)
    reviews.first.to_seed_string.must_equal review_string
  end

  it 'should return upcoming movies' do
    movies = @seed_generator.get_upcoming_movies
    movies.first.year.wont_be_nil
  end

  it 'should get the details for one movie by id' do
    movie = @seed_generator.get_movie(10104)
    movie.title.must_equal "Fried Green Tomatoes"
  end

end