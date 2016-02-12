class UsersController < ApplicationController
  
  def show
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_path
    end
  end
    
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user #user#showへリダイレクトする処理です。TOPページへリダイレクトするときはredirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :area)
  end
end