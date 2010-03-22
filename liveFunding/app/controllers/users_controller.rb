class UsersController < ApplicationController

  skip_before_filter :is_authenticated?, :only => [ :index, :new, :create ]
  
  def index
    @user = User.new
    redirect_to :back
	end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = 'Account created'
      redirect_to(root_path) 
    else
      render :action => "new"
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:notice] = 'Details were successfully updated.'
      render :action => "edit"
    else
      render :action => "edit" 
    end
  end

  def destroy
    # Using current_user ensures that only current_user can be destroyed (instead of finding by parameter)
    log_user_out!
    current_user.destroy
    redirect_to(login_path)
  end
  def delete_image
    @user = User.find(params[:user])
    @user.photo = nil
    @user.save
    params[:id]=@user.id
    redirect_to :back
  end
end
