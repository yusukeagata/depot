class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :product_params, only: [:update,]
  before_action :set_search, only: [:index, :new, :edit, :show, :search]



  # GET /products
  # GET /products.json
  def index
    #@products = Product.all.order(:title).paginate :page=>params[:page], per_page: 20
    @products = @search.result.paginate :page=>params[:page], per_page: 20
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: '更新しました' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    begin
      @product.destroy
      flash[:notice] = "商品#{@product.title}を削除しました。"
    rescue Exception => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
    #@product.destroy
    #redirect_to products_url, notice: '商品を削除しました'
    #respond_to do |format|
      #format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      #format.json { head :no_content }
    #end
  end
  def who_bought
    @product = Product.find(params[:id])
    respond_to do |format|
      format.atom
    end
  end
  def search
    @products = @search.result.paginate :page=>params[:page], per_page: 20
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price)
    end
    
    def set_search
      @search = Product.search(params[:q])
    end
end
