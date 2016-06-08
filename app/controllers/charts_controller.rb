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

  end

  def gerritCharts
    download = params[:download]

    if download.nil?
    @owners = {}
    else
    @owners = OwnerHandler.changes_by_owner
    end
  end


end
