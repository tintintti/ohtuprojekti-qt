class DownloadController < ApplicationController
  def download
    file = File.open("/home/ahjyrkia/qt-software-project/app/assets/textdata/theFile.txt", "rb")
    contents = file.read
    send_data(contents, filename:"theFile.txt")
  end
end
