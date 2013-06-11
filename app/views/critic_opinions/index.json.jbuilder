json.array!(@critic_opinions) do |critic_opinion|
  json.extract! critic_opinion, :like, :user_id, :critic_id
  json.url critic_opinion_url(critic_opinion, format: :json)
end