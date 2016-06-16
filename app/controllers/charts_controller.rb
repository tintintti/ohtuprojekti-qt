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
      time =  Time.at(Commit.all.sort_by{|c| c.stamp}.first.stamp).to_date
    end

    if amount == nil
      amount = 100
    end

    @authors = GitHandler.author_commits time.to_time.to_i, amount.to_i
  end

  def gerritCharts

    @owners = OwnerHandler.changes_by_owner

    # owners_data = Rails.cache.read "owners_data"
    #
    # if Rails.cache.read("downloading") != true && owners_data == nil
    #   Rails.cache.write "downloading", true
    #   GerritData.delay.perform_later
    # else
    #   @owners = owners_data
    # end

    # download = params[:download]
    #
    # if download.nil?
    #   @owners = Rails.cache.read "owners_data"
    # else
    #   owners_data = GerritData.perform_later
    # end
  end


end
