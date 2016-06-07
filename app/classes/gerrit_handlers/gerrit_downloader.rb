class GerritDownloader
  include HTTParty
  base_uri 'https://codereview.qt-project.org'

  def projects
    projects = self.class.get("/projects/").body.lines.to_a[1..-1].join
    JSON.parse(projects)
  end

  def changes
    change = self.class.get("/changes/").body.lines.to_a[1..-1].join
    JSON.parse(change)
  end

  def change(id)
    details = self.class.get("/changes/#{id}/detail").body.lines.to_a[1..-1].join
    JSON.parse(details)
  end

end
