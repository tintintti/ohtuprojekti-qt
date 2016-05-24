json.array!(@categories) do |category|
  json.extract! category, :id, :cid, :name, :description, :slug, :parentCid, :topic_count, :post_count, :disabled, :order, :link, :numRecentReplies, :totalPostCount, :totalTopicCount
  json.url category_url(category, format: :json)
end
