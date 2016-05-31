class SessionsController < ApplicationController
  def new
    
  end

  def create
    if params[:username] == "tunnus" && params[:password] == "passu"
      session[0] = 1
      redirect_to :root, notice: "Tervetuloa!"
    else
      redirect_to :back, alert: "Nimi tai salasana väärin"
    end
  end

  def destroy
    reset_session

    redirect_to :root, notice: "Kirjauduit ulos."
  end

end
