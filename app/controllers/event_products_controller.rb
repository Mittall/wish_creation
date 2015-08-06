class EventProductsController < ApplicationController
  before_action :set_event_product, only: [:show, :edit, :update, :destroy]

  # GET /event_products
  # GET /event_products.json
  def index	
	if user_is_logged_in?
		@event_products= EventProduct.paginate(:page => params[:page], :per_page => 1)
		@contributor = Contributor.new
		@product = Product.new
       
	else
		redirect_to login_url
	end

	#@user = !current_user
	#@event_products = @user.event_products.all
  end

  # GET /event_products/1
  # GET /event_products/1.json
  def show
	#	
	session[:event_product_id] = params[:id]	
	@event_product = EventProduct.find(params[:id])
	@contributor_total = Contributor.new

	#return @show_event_product
  end

  # GET /event_products/new
  def new
    @event_product = EventProduct.new
    #
    @event = Event.all

  end

  # GET /event_products/1/edit
  def edit
			@event_product = EventProduct.find(params[:id])
			@event = Event.all
  end

  # POST /event_products
  # POST /event_products.json
  def create
		@product = Product.new
		@event_product = EventProduct.new(event_product_params)
	 # gain_price = event_product_params[:price_to_gain].to_i
    @event_product.event_id = session[:event_id]
    @event = Event.find(session[:event_id])

    respond_to do |format|
      if @event_product.save
        format.html { redirect_to @event_product, notice: 'Wish Item was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @event_product }
	 			format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @event_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_products/1
  # PATCH/PUT /event_products/1.json
  def update
    respond_to do |format|
      if @event_product.update(event_product_params)
        format.html { redirect_to @event_product, notice: 'Wish Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_products/1
  # DELETE /event_products/1.json
  def destroy
    @event_product.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
			#format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_product
      @event_product = EventProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_product_params
      params.require(:event_product).permit(:event_id, :product_id, :price_to_gain)
    end
end
