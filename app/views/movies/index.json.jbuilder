json.array!(@movies) do |movie|
  json.extract! movie, :rt_id, :description, :year, :title
  json.url movie_url(movie, format: :json)
end