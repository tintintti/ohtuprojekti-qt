json.array!(@users) do |user|
  json.extract! user, :id, :username, :userslug, :email, :picture, :fullname, :signature, :reputation, :postcount, :banned, :status, :did, :lastonline
  json.url user_url(user, format: :json)
end
