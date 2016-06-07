class GerritDownloader
  include HTTParty
  base_uri 'https://codereview.qt-project.org'

  def projects
    projects = self.class.get("/projects/").body
    projects = projects.lines.to_a[1..-1].join
  end

  def changes
    self.class.get("/changes/").body
  end

  def change(id)
    self.class.get("/changes/#{id}").body
  end

end
