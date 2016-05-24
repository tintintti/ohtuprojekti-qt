json.array!(@topics) do |topic|
  json.extract! topic, :id, :tid, :did, :cid, :mainPid, :title, :slug, :timestamp, :lastposttime, :post, :count, :viewcount, :locked, :pinned, :isQuestion, :isSolved, :relativeTime, :lastposttimeISO
  json.url topic_url(topic, format: :json)
end
