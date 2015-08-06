class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
      if current_user
	#display only the logged in user
        @user = current_user
	@events = @user.events.all
	
	@event_status = params[:status]
	
	if @event_status == 'All' 
	
        	@events = @user.events.all

	elsif @event_status == 'Newly added event'
		@events = @user.events.find(:all, :conditions => ["start_date = ?", Date.today])
                
	elsif @event_status == 'Upcomming event'
		@events = @user.events.find(:all, :conditions => ["start_date > ?",Date.today ])

	elsif @event_status == 'Ongoing event'
		@events = @user.events.find(:all, :conditions => ["start_date < ? And end_date >= ?", Date.today, Date.today]) 

	elsif @event_status == 'Finished event'
		@events = @user.events.find(:all, :conditions => ["end_date < ?",Date.today ])
		
	else 
		@events = @user.events.all

	end
	
	#@event_products = @events.event_product.all
      else
	respond_to do |format|
	format.html { redirect_to login_url, notice: "You Must Have to Login...!!!"  }
        format.json { head :no_content }
        end
      end
  end

  def listuser
     @user = User.all
      #@event. << current_user
      #@user.save
  end

  # GET /events/1
  # GET /events/1.json
  def show
      @user = User.all
      session[:event_id] = params[:id]	
      @event = Event.find(params[:id])
			#@event_data = Event.find_by_use_id(params[:user_id])
			#@event_product = EventProduct.find(session[:event_product_id])	
  end

  # GET /events/new
  def new
     if user_is_logged_in?
    	@event = Event.new
      else
	respond_to do |format|
	format.html { redirect_to login_url, notice: "You Must Have to Login...!!!"  }
        format.json { head :no_content }
        end
     end

  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    #fetch user id from user table 
    @event.user = current_user
    @event.get_status
    #@event_product = EventProduct.find(session[:event_product_id])
       respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Wish was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }				
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
  
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Wish was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:user_id, :event_name, :description, :status, :start_date, :end_date)
    end


end
