class SessionsController < ApplicationController
  
  # Use the database for sessions, to store highly confidential information

  
  
  # Will not run the filter is_authenticated before the index, new and create action
  skip_before_filter :is_authenticated?, :only => [ :create ]
  
  
  def create
    authenticated_user = User.authenticate(params[:user][:username], params[:user][:password])
  
    if authenticated_user
      log_user_in(authenticated_user)  # lib/user_authentication.rb
      redirect_to users_path
    else
      flash[:error] = "Login failed, check your username and password."
      redirect_to login_path
    end
     
  end
  
    
  def destroy
    reset_session
    redirect_to root_path
  end
  
end
