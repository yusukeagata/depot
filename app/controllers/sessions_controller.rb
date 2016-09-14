class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
     @search = Product.search(params[:q]) # この行を追加
  end

  def create
    user = User.find_by_name(params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: "無効なユーザー、パスワードの組み合わせです"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "ログアウトしました。"
  end
end
