class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Sign-up successful!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash[:danger] = "There was a problem updating your settings. Please ensure all fields and image sizes are valid."
      redirect_to edit_user_path(@user)
    end
  end

  def show
  	@user = User.find(params[:id])
  end

private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture)
    end

end
