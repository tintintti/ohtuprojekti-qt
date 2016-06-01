require 'httparty'

class ParseGitStats
  def self.create_everything_required_for_gitstats
    all_repositories = HTTPary.get("https://api.github.com/users/qtproject/repos?per_page=128").parsed_response
    all_repositories.each do |repo|
      # git clone repo
      create_and_move_stats_to_views
      add_commits_to_database
      somehow_manage_adding_new_routes
      # rm repo and gitstats
    end

  end

  def self.create_and_move_stats_to_views

  end

  def self.add_gitdata_to_db

  end

  def self.somehow_manage_adding_new_routes

  end
end