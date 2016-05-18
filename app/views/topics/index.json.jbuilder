json.array!(@topics) do |topic|
  json.extract! topic, :id, :tid, :slug, :raw_json
  json.url topic_url(topic, format: :json)
end
