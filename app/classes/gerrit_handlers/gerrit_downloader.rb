class GerritDownloader
  include HTTParty
  base_uri 'https://codereview.qt-project.org'

  def projects
    projects = body_no_first_line(self.class.get("/projects/"))
    JSON.parse(projects)
  end

  def changes
    change = body_no_first_line(self.class.get("/changes/"))
    JSON.parse(change)
  end

  def change(id)
    details = body_no_first_line(self.class.get("/changes/#{id}/detail"))
    JSON.parse(details)
  end

  def body_no_first_line(response)
    response.body.lines.to_a[1..-1].join
  end

end
