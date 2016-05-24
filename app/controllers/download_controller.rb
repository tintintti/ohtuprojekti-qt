class DownloadController < ApplicationController
  def download
    file = File.open(File.join(Rails.root, 'app/assets/textdata/theFile.txt'), "rb")
    contents = file.read
    send_data(contents, filename:"theFile.txt")
  end

  def emails
    @contents = email_counts
    respond_to do |format|
      format.html
      format.json {render json: @contents}
    end
  end

  def email_counts
    topics = Topic.all
    emails = Hash.new
    topics.each do |topic|
      user = topic.first_post.ret_user
      email = user.email
      # if the user has removed their account the email is nil
      if (email == nil)
         next
      end
      email = email.split("@")
      email = email[1]
      if !emails.has_key? email
        emails[email] = {label:email, value:0, users:[]}
      end
      emails[email][:value] += 1
      emails[email][:users] << {user:user.username, slug:user.userslug}
    end
    data = []
    emails.each { |key, value| data << value }
    sorted_data = data.sort_by{ |item| item[:value] }
  end

end
