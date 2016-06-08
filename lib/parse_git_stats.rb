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


  def self.iterate_over_qt_projects strategy
    dir='/Users/Studies/koulu/qt-software-project/qt-projects'
    Dir.foreach(dir) do |file|
      next if file == '.' or file == '..' or file == '.git'
      if strategy == "git_stats"
        generate_git_stats file
      elsif strategy == "db"
        save_repo_data file
      end
    end
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
             |commit| Commit.create sha:commit.sha, repo_id:newRepo.id, author_id:a.id, stamp:commit.stamp } }
    puts "done processing #{file}"
  end

  def self.baa
    authors = Author.all
    ids_corrected = []
    authors.each do |a|
      next if a.id.in? ids_corrected
      dubbels = Author.where("name = ? OR email = ?", a.name, a.email)
      ids = dubbels.pluck(:id)
      ids_corrected.concat ids
      Commit.where(author_id:ids).update_all(author_id:a.id)
      ids.each do

end
    end
  end


  def self.baa_baa
    authors = Author.all
    total_dubbels = [];
    authors.each do |a|
      dubbels = Author.where("name = ? OR email = ?", a.name, a.email)
      break;

      ids = dubbels.pluck(:id)

      total_dubbels.concat ids
    end
    return total_dubbels.uniq
  end
end

#a567ccdd387988a97f78ac890034dce3d972eac9
# repo = GitStats::GitData::Repo.new(path: 'qt-projects/qt-labs-umlquick', first_commit_sha: '72dd7b21734ed80e3f3670a7e5c85a298a73e5a1', last_commit_sha: 'HEAD')
# repo = GitStats::GitData::Repo.new(path: '.', first_commit_sha: 'a567ccdd387988a97f78ac890034dce3d972eac9', last_commit_sha: 'HEAD')
# repo = GitStats::GitData::Repo.new(path: 'qt-projects/qt', first_commit_sha: '8f427b2b914d5b575a4a7c0ed65d2fb8f45acc76', last_commit_sha: 'HEAD')
