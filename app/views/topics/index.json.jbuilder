json.array!(@topics) do |topic|
  json.extract! topic, :id, :tid, :uid, :cid, :mainPid, :title, :slug, :timestamp, :lastposttime, :postcount, :viewcount, :locked, :pinned, :isQuestion, :isSolved, :relativeTime, :lastposttimeISO
  json.url topic_url(topic, format: :json)
end
