class ApplicationController < ActionController::Base
  #before_filter :authorize
  before_action :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def redirect_to_with_moved_permanently(options = {}, response_status = {})
    response_status.reverse_merge!(status: :moved_permanently)
    redirect_to_without_moved_permanently(options, response_status)
  end
  alias_method_chain :redirect_to, :moved_permanently
  
  private
  def current_cart
    Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
  
  private
  def authorize
    unless User.find_by_id(session[:user_id])
    redirect_to login_url, notice: "ログインしてください"
    end
  end

end
