require 'httparty'

class ParseGitStats
  def self.load_git_repos
    all_repositories = HTTParty.get("https://api.github.com/users/qtproject/repos?per_page=128").parsed_response
    i = 0
    all_repositories.each do |repo|
      i += 1
      clone_git_repos repo
    end
  end

  def self.clone_git_repos repo
    `git clone #{repo["clone_url"]}`
    repo_name = repo["name"]
    `cd #{repo_name} ; ls | grep -v .git | xargs rm -rf`
    `mv #{repo_name} qt-projects/`
  end

  def self.iterate_over_qt_projects strategy
    old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil
    dir='/Users/Studies/koulu/qt-software-project/qt-projects'
    Dir.foreach(dir) do |file|
      next if file == '.' or file == '..' or file == '.git'
      if strategy == "git_stats"
        generate_git_stats file
      elsif strategy == "db"
        save_repo_data file
      end
    end
    ActiveRecord::Base.logger = old_logger
  end

  def self.generate_git_stats file
    repo = "/Users/Studies/koulu/qt-software-project/qt-projects/#{file}"
    ls = `ls #{repo}`
    puts "processing #{file}"
    if ls != ""
      puts "directory already has git_stats"
      return
    end
    `cd #{repo} ; git_stats generate`
    puts "done processing #{file}"
  end

  def self.save_repo_data file
    puts "processing #{file}"
    root_commits = `cd qt-projects/#{file} ; git rev-list --max-parents=0 HEAD`
    first_commit = root_commits.split("\n").last
    repo = GitStats::GitData::Repo.new(path: "qt-projects/#{file}", first_commit_sha: first_commit, last_commit_sha: 'HEAD')
    newRepo = Repository.new name:file
    newRepo.save
    repo.authors.each{
        |author| a = Author.new(email:author.email, name:author.name) ; a.save ;
         author.commits.each{
             |commit| Commit.create sha:commit.sha, repository_id:newRepo.id, author_id:a.id, stamp:commit.stamp } } ; nil
    puts "done processing #{file}"
  end

  def self.link_similar_authors_and_their_commits
    authors = Author.all
    ids_corrected = []
    authors.each do |a|
      next if a.id.in? ids_corrected
      doubles = Author.where("name = ? OR email = ?", a.name, a.email)
      double_ids = doubles.pluck(:id)
      double_ids.delete(a.id)
      ids_corrected.concat double_ids
      Commit.where(author_id:double_ids).update_all(author_id:a.id)
      Author.where(id:double_ids).update_all(linked_id:a.id)
    end
  end
end
