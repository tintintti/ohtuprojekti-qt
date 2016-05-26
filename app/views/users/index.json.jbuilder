json.array!(@users) do |user|
  json.extract! user, :id, :username, :userslug, :email, :picture, :fullname, :signature, :reputation, :postcount, :banned, :status, :uid, :lastonline
  json.url user_url(user, format: :json)
end
