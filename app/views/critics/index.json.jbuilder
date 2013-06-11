json.array!(@critics) do |critic|
  json.extract! critic, :name, :url, :publication
  json.url critic_url(critic, format: :json)
end