json.array!(@reputation_post_topics) do |reputation_post_topic|
  json.extract! reputation_post_topic, :id, :tid, :reputation, :postcount
  json.url reputation_post_topic_url(reputation_post_topic, format: :json)
end
