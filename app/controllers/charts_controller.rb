class ChartsController < ApplicationController
  def index
  end

  def view
    @post_counts = UserHandler.user_postcounts
    @users_by_email = UserHandler.users_by_email_provider
  end

end
