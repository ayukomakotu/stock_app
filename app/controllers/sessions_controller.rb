class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(number: params[:session][:number])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to items_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end
