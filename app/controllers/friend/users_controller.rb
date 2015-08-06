class Friend::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  #before_action :require_admin

  # GET /users
  # GET /users.json
  def index
    
    if user_is_logged_in?
       	#@users = (current_user.blank? ? User.all : User.find(:all, :conditions => ["id != ?", current_user.id] ))   
				@users = User.where('id != ? AND first_name != ?', current_user.id, "admin").search(params[:search]).paginate(:per_page => 1, :page => params[:page])

				@cnt = User.where('id != ? AND first_name != ?', current_user.id, "admin")
        @count_user = @cnt.count
				@contributor = Contributor.new
	
   else
			respond_to do |format|
			format.html { redirect_to login_url, notice: "You Must Have to Login...!!!" }
      format.json { head :no_content }
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
        #User.find(:all, :include => :events, :conditions => { "events_users.event_id" => nil})
  end

  # GET /users/new
  def new
    @users = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /user_sessions
  # POST /user_sessions.xml
  def create
    @users = User.new(user_params)
    respond_to do |format|
      if @users.save
        @users.role = Role.find(params[:role_id])
        format.html { redirect_to friend_users_url, notice: "successfully_created" }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @users.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @users.update(user_params)
        @users.role = Role.find(params[:role_id])
        format.html { redirect_to friend_users_url, notice:"successfully_updated" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @users.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @users.destroy
    respond_to do |format|
      format.html { redirect_to friend_users_url, notice: "successfully_destroyed" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @users = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit!
    end

    def set_header_menu_active
      @users = "active"
    end

end
