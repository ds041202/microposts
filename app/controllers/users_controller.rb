class UsersController < ApplicationController
  
  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
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
    if @user.update_attributes(user_params) and
      current_user == @user
      redirect_to @user #user#showへリダイレクトする処理です。TOPページへリダイレクトするときはredirect_to root_url
    else 
      redirect_to edit_user_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :area)
  end
end