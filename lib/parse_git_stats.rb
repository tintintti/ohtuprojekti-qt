require 'httparty'

class ParseGitStats
  def self.create_everything_required_for_gitstats
    all_repositories = HTTParty.get("https://api.github.com/users/qtproject/repos?per_page=128").parsed_response
    i = 0
    all_repositories.each do |repo|
      i += 1
      # git clone repo
      load_git_stuff repo
      # create_and_move_stats_to_views
      # add_commits_to_database
      # somehow_manage_adding_new_routes
      # rm repo and gitstats
      puts i
      puts "/"
      puts all_repositories.count
    end

  end

  def self.create_and_move_stats_to_views

  end

  def self.add_gitdata_to_db

  end

  def self.somehow_manage_adding_new_routes

  end

  def self.load_git_stuff repo
    `git clone #{repo["clone_url"]}`
    repo_name = repo["name"]
    `cd #{repo_name} ; ls | grep -v .git | xargs rm -rf`
    `mv #{repo_name} qt-projects/`
  end
end

repo = GitStats::GitData::Repo.new(path: 'qt-projects/qt-labs-umlquick', first_commit_sha: '72dd7b21734ed80e3f3670a7e5c85a298a73e5a1', last_commit_sha: 'HEAD')
