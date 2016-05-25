class ChartsController < ApplicationController
  def index
  end

  def view
    @postcounts = UserHandler.user_postcounts
  end

end
