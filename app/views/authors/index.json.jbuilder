json.array!(@authors) do |author|
  json.extract! author, :id, :name, :email, :linked_id
  json.url author_url(author, format: :json)
end
