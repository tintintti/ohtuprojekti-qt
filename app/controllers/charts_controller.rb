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
    time = params[:time]
    amount = params[:amount]

    @authors = GitHandler.author_commits time, amount
    @emails = GitHandler.author_emails
  end

  def gerritCharts
    @owners  = OwnerHandler.changes_by_owner
    @change_averages = ChangeHandler.averages
    @changes = ChangeHandler.change_data
    @domains = OwnerHandler.owner_domains
  end


end
