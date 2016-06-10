class ChartsController < ApplicationController
  before_action :ensure_that_logged_in, except: [:index]

  def index

  end

  def forumCharts
    @post_counts = UserHandler.user_postcounts
    @email_counts = UserHandler.count_emails
    @users_by_email = UserHandler.users_by_email_provider
  end

  def gitCharts
    # @authors = Author.all
    @authors = GitHandler.author_commits
    @commits = Commit.where("stamp > 1420070400")
    # 2015 jälkeiset authorien commitit
    # @authors = Author.all.sort_by{|a| -(a.commits.where("stamp > 1420070400").count || 0)}
    # @commits = Commit.all

  end

  def gerritCharts
    download = params[:download]

    if download.nil?
      @owners = Rails.cache.read "owners_data"
    else
      owners_data = OwnerHandler.changes_by_owner
      @owners = owners_data
      Rails.cache.write "owners_data", owners_data
    end
  end


end
