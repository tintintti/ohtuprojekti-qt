class UserHandler

  def self.user_postcounts
    arr = Array.new
    users = User.all

    # lowPostCount = 0

    users.each do |user|

      # if (user.postcount < n)
      #   lowPostCount += 1
      #   next
      # end
      entry = { "label" => user.username, "value" => user.postcount }
      arr.push(entry)
    end
    # entry = { "label" => "users with < #{n} posts", "postcount" => lowPostCount }
    # arr.push(entry)
    arr
  end

  def self.user_emails
    arr = Array.new
    users = User.all

    users.each do |user|
      entry = { "user" => user.username, "email" => user.email}
      arr.push(entry)
    end
    arr
  end

end
