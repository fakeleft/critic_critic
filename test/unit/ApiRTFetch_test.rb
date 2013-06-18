#
#
#
require 'test_helper'
require 'ApiRTFetch'

describe 'ApiRTFetch' do

  before do
    @a = ApiRTFetch.new
    # @base_uri = 'http://api.rottentomatoes.com/api/public/v1.0'
    # @api_key = YAML::load(File.open("lib/api_key.yml"))
  end

  it 'should create an instance without any arguments' do
    assert_instance_of ApiRTFetch, ApiRTFetch.new
  end

  # it 'should fetch and parse JSON from RT API' do
  #   @a.get_response("/lists/dvds/upcoming.json?apikey=#{@api_key}")
  # end

end
