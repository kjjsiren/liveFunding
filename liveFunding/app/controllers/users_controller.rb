class UsersController < ApplicationController

  # Will skip the filter is_authenticated before the index, new and create action
  skip_before_filter :is_authenticated?, :only => [ :index, :new, :create ]
  
  
  def index
    @user = User.new
    redirect_to :back
	end

  def new
    @user = User.new
  end

  # Enables editing of the user profile.
  # Using current_user makes sure that the user profile can't be edited by other users.
  def edit
    user = User.find(params[:id])
    if user == current_user 
      @user = User.find(params[:id])
    else
     redirect_to(root_path)
    end
  rescue
    flash[:notice] = I18n.t('flash.users.invalid_id')
    redirect_to(root_path)  
  end

  # Create a new user
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'Account created'
      redirect_to(root_path) 
    else
      render :action => "new"
      flash[:error] ="Error while saving, account not created"
    end
  end

  # Update the user in the database:
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:notice] = 'Details were successfully updated.'
      render :action => "edit"
    else
      render :action => "edit" 
    end
  end

  # Delete the user from the database:
  def destroy
    # Using current_user ensures that only current_user can be destroyed (instead of finding by parameter)
    log_user_out!
    current_user.destroy
    redirect_to(login_path)
  end

	# Delete the image of the user:  
	def delete_image
    @user = User.find(params[:user])
    @user.photo = nil
    @user.save
    params[:id]=@user.id
    redirect_to :back
  end
end
