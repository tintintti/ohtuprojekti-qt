class GerritDownloader
  include HTTParty
  base_uri 'https://codereview.qt-project.org'

  # returns a hash
  def projects
    projects = body_no_first_line(self.class.get("/projects/"))
    JSON.parse(projects)
  end

  # returns an array
  def changes
    change = body_no_first_line(self.class.get("/changes/"))
    JSON.parse(change)
  end

  def n_changes(amount)
    change = body_no_first_line(self.class.get("/changes/?n=#{amount}"))
    JSON.parse(change)
  end

  def n_changes_with_status(amount, status)
      change = body_no_first_line(self.class.get("/changes/?q=status:#{status}&n=#{amount}"))
      JSON.parse(change)
  end

  # returns a hash
  def change(id)
    details = body_no_first_line(self.class.get("/changes/#{id}/detail"))
    JSON.parse(details)
  end

  def body_no_first_line(response)
    response.body.lines.to_a[1..-1].join
  end

end
