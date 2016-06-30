class UserHandler

  def self.user_postcounts
    postcounts = []
    posts = Post.all

    users = {}
    slugs = {}
    posts.each do |post|
      user = post.ret_user
      name = "removed user"
      if user != nil
        name = user.username
        slugs[user.username] = user.userslug
      end
      if !users.key? name
        users[name] = 0
      end
      users[name] += 1
    end

    users.each do |key, value|
      postcounts << {label: key, value: value}
    end
    [postcounts, slugs]
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
