class DownloadController < ApplicationController

  def download
    data = count_emails
    @contents = ActiveSupport::JSON.encode(data)
  end

  def count_emails
    topics = Topic.all
    emails = Hash.new
    topics.each do |t|
      topic = ActiveSupport::JSON.decode(t.raw_json)
      email = topic["posts"][0]["user"]["email"]
      # guest users don't have an email so check for email
      if email == nil
        next
      end
      email = email.split("@")
      email = email[1]
      if !emails.has_key?(email)
        emails[email] = 0
      end
      emails[email] += 1
    end
    emails
  end

end
