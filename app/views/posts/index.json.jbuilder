json.array!(@posts) do |post|
  json.extract! post, :id, :pid, :uid, :tid, :content, :timestamp, :reputation, :votes, :edited, :deleted
  json.url post_url(post, format: :json)
end
