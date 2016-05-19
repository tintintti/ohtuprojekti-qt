class DownloadController < ApplicationController

  def download
    data = count_emails
    contents = ActiveSupport::JSON.encode(data)
    send_data(contents, filename:"emails.txt")
  end

  def count_emails
    topics = Topic.all
    emails = Hash.new
    topics.each do |topic|
      topic = ActiveSupport::JSON.decode(topic.raw_json)
      email = topic["posts"][0]["user"]["email"]
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
