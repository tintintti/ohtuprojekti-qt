json.array!(@commits) do |commit|
  json.extract! commit, :id, :repository_id, :author_id, :sha, :stamp
  json.url commit_url(commit, format: :json)
end
