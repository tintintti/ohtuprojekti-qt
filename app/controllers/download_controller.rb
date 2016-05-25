class DownloadController < ApplicationController
  def download
    file = File.open(File.join(Rails.root, 'app/assets/textdata/theFile.txt'), "rb")
    contents = file.read
    send_data(contents, filename:"theFile.txt")
  end

  def emails
    @contents = UserHandler.users_by_email_provider
    respond_to do |format|
      format.html
      format.json { render json: @contents }
    end
  end

end
