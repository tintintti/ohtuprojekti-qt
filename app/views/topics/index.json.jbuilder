json.array!(@topics) do |topic|
  json.extract! topic, :id, :tid, :user
  json.url topic_url(topic, format: :json)
end
