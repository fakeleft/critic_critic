json.array!(@user_opinions) do |user_opinion|
  json.extract! user_opinion, :like, :user_id, :movie_id
  json.url user_opinion_url(user_opinion, format: :json)
end