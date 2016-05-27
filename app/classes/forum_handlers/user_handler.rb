class UserHandler

  def self.user_postcounts
    arr = Array.new
    users = User.all

    users.each do |user|
      entry = { label: user.username, value: user.postcount }
      arr.push(entry)
    end
    arr
  end

  def self.users_by_email_provider
    users = User.all
    emails = {}
    users.each do |user|
      email = user.email
      # if user has removed their account, email is nil
      if email == nil
        next
      end
      email = format_email(email)
      if !emails.key? email
        emails[email] = []
      end
      emails[email] << {user: user.username, slug: user.userslug}
    end
    emails
  end

  def self.format_email(email)
    email = email.split("@")
    email = email[1]
    email = email.split(".")
    email = email[-2]
  end

end
