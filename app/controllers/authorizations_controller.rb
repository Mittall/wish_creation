class AuthorizationsController < ApplicationController   

before_filter :require_user, :only => [:destroy]

  def create
    omniauth = request.env['omniauth.auth'] #this is where you get all the data from your provider through omniauth
    @auth = Authorization.find_from_omniauth_data(omniauth)

    if current_user
      flash[:notice] = "Successfully added #{omniauth['provider']} authentication"
      current_user.authorizations.create(:provider => omniauth['provider'], :uid => omniauth['uid']) #Add an auth to existing user
      redirect_to edit_user_path(:current)

    elsif @auth
      flash[:notice] = "Welcome back #{omniauth['provider']} user"
      @user_session = UserSession.create(@auth.user, true) #User is present. Login the user with his social account
			session[:user_id] = @auth.user.id
			session[:user_role] = @auth.user.role.role_type
      redirect_to root_url

    else
      @new_auth = Authorization.create_from_omniauth_data(omniauth, current_user) #Create a new user
			UserSession.create(@new_auth.user, true) #Log the authorizing user in.
      flash[:notice] = "Welcome #{omniauth['provider']} user. Your account has been created."
			session[:user_id] = @new_auth.user.id
      session[:user_role] = @new_auth.user.role.role_type
      redirect_to root_url
    end

  end

 

=begin
	auth = request.env["omniauth.auth"]
  authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
  flash[:notice] = "Signed in successfully."
  sign_in_and_redirect(:user, authentication.user)
=end 

  def failure
    flash[:notice] = "Sorry, You din't authorize"
    #redirect_to root_url
  end
 
  def blank
    render :text => "Not Found", :status => 404
  end
 
  def destroy
    @authorization = current_user.authorizations.find(params[:id])
    flash[:notice] = "Successfully deleted #{@authorization.provider} authentication."
    @authorization.destroy
    #redirect_to edit_user_path(:current)
  end
end
