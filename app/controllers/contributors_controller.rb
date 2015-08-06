class ContributorsController < ApplicationController
  before_action :set_contributor, only: [:show, :edit, :update, :destroy]

  # GET /contributors
  # GET /contributors.json
  def index
    if user_is_logged_in?
   # @event_product = EventProduct.new
	@contributor = Contributor.find(:all, :conditions => ["user_id = ?", current_user.id] ).paginate(:page => params[:page], :per_page => 3)

	@contribute_me = params[:user_id]
	@contribute_friend = params[:user_contribute_id]

	if @contribute_me == 'my'
		@contributor = Contributor.find(:all, :conditions => ["user_id = ?", current_user.id] ).paginate(:page => params[:page], :per_page => 3)
		elsif @contribute_friend == 'friend'
			@contributor = Contributor.find(:all, :conditions => ["user_contribute_id = ?", current_user.id] ).paginate(:page => params[:page], :per_page => 3)
		else
			
		end

    else
	respond_to do |format|
	format.html { redirect_to login_url, notice: "First Login...!!!" }
        format.json { head :no_content }
        end    
    end
  end

  # GET /contributors/1
  # GET /contributors/1.json
  def show
	#@event_product = EventProduct.find(params[:id])
  end

  # GET /contributors/new
  def new
    @contributor = Contributor.new
  end

  # GET /contributors/1/edit
  def edit
  end

  # POST /contributors
  # POST /contributors.json
  def create
	 given_price = contributor_params[:given_price].to_i
  
	 if given_price > 100 
		values = { 
		:business => 'mittal.vitrainee@gmail.com',
		:cmd => '_cart',
		:upload => 1,
		:return => fundfromfriend_url(session[:event_product_id],contributor_params[:given_price]),
		}	
	 	values.merge!({
		  "amount_1" => contributor_params[:given_price],
		  "item_name_1" => 'abcs',
		  "item_number_1" => 1,
		  "quantity_1" => 1
	  })  
   	# For test transactions use this URL
		redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
	 else
		redirect_to event_product_url(session[:event_product_id])
		flash[:alert] = "Contribution price must be greater than 100 Rs."
   end 
  end

  # PATCH/PUT /contributors/1
  # PATCH/PUT /contributors/1.json
  def update
    respond_to do |format|
      if @contributor.update(contributor_params)
        format.html { redirect_to @contributor, notice: 'Contributor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @contributor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributors/1
  # DELETE /contributors/1.json
  def destroy
    @contributor.destroy
    respond_to do |format|
      format.html { redirect_to contributors_url }
      format.json { head :no_content }
    end
  end

	def userfund
		@contributor = Contributor.new(given_price: params[:given_price])
    @contributor.user = current_user
    @contributor.event_product_id = session[:event_product_id]
    @user_event = @contributor.get_contribution_id(session[:event_product_id])
    @userId = @contributor.get_user_id(@user_event)
    @contributor.user_contribute_id = @userId
		
		@contributor.given_price = params[:given_price]

		@event_product = EventProduct.find(session[:event_product_id])

		#@contributor.given_price = tmp
	
    #@contributor.event_product_id = event_product

    if @contributor.save
			redirect_to event_event_product_url(@user_event, session[:event_product_id])
    end
	end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contributor
      @contributor = Contributor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contributor_params
      params.require(:contributor).permit(:user_id, :event_product_id, :given_price)
    end
end