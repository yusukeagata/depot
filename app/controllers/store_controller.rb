class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    @search = Product.search(params[:q]) # この行を追加
    @products = @search.result.paginate :page=>params[:page], per_page: 20
    #@products = Product.order(:title).paginate :page=>params[:page], per_page: 20
    @cart = current_cart
  end
end
