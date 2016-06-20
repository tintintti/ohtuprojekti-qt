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

    if Commit.all.length < 1
      time = "01/01/2015".to_date
    elsif time == nil
      time =  Time.at(Commit.all.sort_by{|commit| commit.stamp}.first.stamp).to_date
    end

    if amount == nil
      amount = 100
    end

    @authors = GitHandler.author_commits time.to_time.to_i, amount.to_i
    @emails = GitHandler.author_emails
  end

  def gerritCharts
    @owners  = OwnerHandler.changes_by_owner
    @change_averages = ChangeHandler.averages
    @changes = ChangeHandler.change_data
    @domains = OwnerHandler.owner_domains
  end


end
