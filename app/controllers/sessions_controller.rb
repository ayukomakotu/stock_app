class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(number: params[:session][:number].to_i)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "ログインに成功しました"
      log_in user
      redirect_back_or items_path
    else
      flash.now[:danger] = '番号またはパスワードが間違っています'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to items_path
  end
end
