class SessionsController < ApplicationController
  def new

  end

  def create
    if params[:username] == "tunnus" && params[:password] == "passu"
      session[0] = 1
      redirect_to :root, notice: "Welcome!"
    else
      redirect_to :back, alert: "Invalid username or password."
    end
  end

  def destroy
    reset_session

    redirect_to :root, notice: "Logged out."
  end

end
