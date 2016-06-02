require 'httparty'

class ParseGitStats
  def self.create_everything_required_for_gitstats
    all_repositories = HTTPary.get("https://api.github.com/users/qtproject/repos?per_page=128").parsed_response
    all_repositories.each do |repo|
      # git clone repo
      load_git_stuff repo
      create_and_move_stats_to_views
      add_commits_to_database
      somehow_manage_adding_new_routes
      # rm repo and gitstats
      break
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
    `cd #{repo_name} ; ls -a | grep -v .git | xargs rm -rf`
  end
end