class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  
  # GET /products
  # GET /products.json

  #@products = Products.includes(:categories)

  def index
    
    #@product = products.joins([:categories])
    #@products = (Product.all).joins(:categories)
    #@product = Product.find(:all, :include => :categories)

    #@products = Product.find(:all, :order => "category_id asc")
    #@products = Product.find(:all, :order => "created_at desc").paginate(:page => params[:page], :per_page => 2)
  	session[:product_id] = params[:id] 
    @products = Product.where("created_at >= ?", 7.days.ago).paginate(:page => params[:page], :per_page => 2)

  end

  # GET /products/1
  # GET /products/1.json

  def show
	#  
     session[:product_id] = params[:id]     
     @product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
    #
    @categories = Category.all
  end

  # GET /products/1/edit
  def edit
	#
	@product = Product.find(params[:id])
	@categories = Category.all
  end

  # POST /products
  # POST /products.json

  def create
    @product = Product.new(product_params)
   
    respond_to do |format|
      if @product.save	
	#@product = Product.new(:product_name => params[:products][:product_name],
	#:category_id => params[:products][:category_id])  
        format.html { redirect_to categories_url, notice: 'Product was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @product }
				format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:category_id, :product_name, :description, :image_one, :price)
    end
  
end
