class GerritDownloader
  include HTTParty
  base_uri 'https://codereview.qt-project.org'

  # returns a hash
  def projects
    download_and_parse "/projects/"
  end

  # returns an array
  def changes
    download_and_parse "/changes/"
  end

  def n_changes(amount)
    download_and_parse "/changes/?n=#{amount}"
  end

  def n_changes_with_status(amount, status)
    download_and_parse "/changes/?q=status:#{status}&n=#{amount}"
  end

  # returns a hash
  def change(id)
    download_and_parse "/changes/#{id}/detail"
  end

  def download_and_parse(url)
    response = self.class.get(url)
    if response.code != 200
      return
    end
    change = body_no_first_line(response)
    JSON.parse(change)
  end

  def body_no_first_line(response)
    response.body.lines.to_a[1..-1].join
  end

end
