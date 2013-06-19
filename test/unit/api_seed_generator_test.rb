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
    VCR.use_cassette('seed_search_movies') do
      movie = @seed_generator.search_movies("Fried&Green&Tomatoes", 1)
      movie.class.must_equal Hash
      movie["movies"][0]["title"].must_equal "Fried Green Tomatoes"
    end
  end

  # this test has an error
  # it 'should get the details for one movie by id' do
  #   VCR.use_cassette('seed_get_details_for_one_movie_by_id')
  #     movie = @seed_generator.get_movie(10104)
  #     movie["title"].must_equal "Fried Green Tomatoes"
  # end

  it 'should get the reviews for one movie by id' do
    VCR.use_cassette('seed_get_reviews_for_one_movie_by_id') do
      reviews = @seed_generator.get_reviews(10104)
      reviews["reviews"].wont_be_nil
    end
  end

  it 'should get a list of upcoming movie ids' do
    VCR.use_cassette('seed_get_upcoming_movie_ids') do
      movie_ids = @seed_generator.get_movie_ids
      movie_ids.class.must_equal Array
      movie_ids.empty?.must_equal false
      movie_ids.length.must_equal 10
    end
  end

  # these tests are driving the refactor


  # it 'should return a single RtMovie' do
  #   movie = @seed_generator.search_movies_new("Fried&Green&Tomatoes", 1)
  #   movie.class.must_equal RtMovie
  #   movie.title.must_equal "Fried Green Tomatoes"
  #   movie.year.must_equal 1991
  #   movie.rt_id.must_equal 10104
  # end

  # it 'should return an array of MovieReviews' do
  #   reviews = @seed_generator.get_movie_reviews_new(10104)
  #   reviews.class.must_equal Array
  #   this_review = reviews[0]
  #   this_review.class.must_equal RtReview
  #   this_review.like.must_equal true
  #   this_review.rt_id.must_equal 10104
  #   this_review.review_url.must_equal "http://www.ew.com/ew/article/0,,309135,00.html"
  #   this_review.critic.name.must_equal "Owen Gleiberman"
  #   this_review.critic.publication.must_equal "Entertainment Weekly"
  # end

end






























