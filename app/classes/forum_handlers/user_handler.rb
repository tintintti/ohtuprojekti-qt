class UserHandler

  def self.user_postcounts
    arr = []
    posts = Post.all

    users = {}
    posts.each do |post|
      user = User.find_by_uid(post.uid)
      name = "removed user"
      if user != nil
        name = user.username
      end
      if !users.key? name
        users[name] = 0
      end
      users[name] += 1
    end

    users.each do |key, value|
      arr << {label: key, value: value}
    end
    arr
  end

  def self.count_emails
    emails = emails_and_users
    data = []
    emails.each do |item|
      data << {label: item[:label].split(".")[0], value: item[:value]}
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
      email = email.split("@")[1].split(".")[0]
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
