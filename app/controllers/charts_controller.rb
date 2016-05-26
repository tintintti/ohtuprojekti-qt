class ChartsController < ApplicationController
  def index
  end

  def view
    @postcounts = UserHandler.user_postcounts
    @email_counts = UserHandler.count_emails
    @users_by_email = UserHandler.users_by_email_provider
  end

end
