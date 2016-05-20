class DownloadController < ApplicationController

  def download
    @contents = count_emails
    respond_to do |format|
      format.html
      format.json {render json: @contents}
    end
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
        emails[email] = {label:email, value:0}
      end
      emails[email][:value] += 1
    end

    data = []
    emails.each do |key, value|
      data << value
    end
    sorted_data = data.sort_by{ |item| item[:value]}
    sorted_data
  end

end
