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

  def self.count_emails
    emails = emails_and_users
    data = []
    emails.each do |item|
      data << {label: item[:label], value: item[:value]}
    end
    data
  end

  def self.users_by_email_provider
    emails = emails_and_users
    data = {}
    emails.each do |item|
      data[item[:label]] = []
      item[:users].each { |user| data[item[:label]] << user }
    end
    data
  end


  def self.emails_and_users
    users = User.all
    emails = {}
    users.each do |user|
      email = user.email
      # if user has removed their account, email is nil
      if email == nil
        next
      end
      email = email.split("@")
      email = email[1]
      if !emails.key? email
        emails[email] = {label:email, value:0, users:[]}
      end
      emails[email][:value] += 1
      emails[email][:users] << {user: user.username, slug: user.userslug}
    end
    data = []
    emails.each_value { |value| data << value }
    sorted_data = data.sort_by { |item| item[:value] }
  end


end
