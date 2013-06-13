require 'ap'
require 'uri'
require 'json'
require 'net/http'

base_uri = 'http://api.rottentomatoes.com/api/public/v1.0'
api_key = '82sk2rzj9bxueps9ptbt7txj'
# movie_resources = "#{base_uri}/movies.json?apikey=#{api_key}"

new_release_search = "#{base_uri}/lists/dvds/current_releases.json?apikey=#{api_key}&page_limit=10"

# jack_query = "&q=Jack&page_limit=1"
# search_for_jack = movie_resources + jack_query

uri = URI(new_release_search)

# get_response includes intelligence in header about success/failure of
# method call.
response = Net::HTTP.get_response(uri)
json = JSON.parse(response.body)

ap json

json["movies"].each do |movie|
  # puts "Movie.create(title: \"#{movie["title"]}\", year: #{movie["year"].to_s}, description: \"#{movie["synopsis"]}\", rt_id: #{movie["id"]})"
  puts "Movie.create(title: \"#{movie["title"]}\", year: #{movie["year"].to_s}, description: \"#{movie["title"]}\", rt_id: #{movie["id"]})"

end



# Movie.create(title: 'The Internship', year: 2013, description: "Dumb guys working at Google", rt_id: 123456)

# json["movies"].each do |movie|
#   Movie.create!(movie["title"] + " " + movie["year"])
# end