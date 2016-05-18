class DownloadController < ApplicationController
  def download
    file = File.open(File.join(Rails.root, 'app/assets/textdata/theFile.txt'), "rb")
    contents = file.read
    send_data(contents, filename:"theFile.txt")
  end

end
