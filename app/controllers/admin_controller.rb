class AdminController < ApplicationController
  def index
    @search = Product.search(params[:q]) # この行を追加
    @total_orders = Order.count
  end
end
