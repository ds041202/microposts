class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  
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
    
  # def following  ←　メソッド名間違っていました。ルーティングを参照。
  #   @title = "Following"
  #   @user  = User.find(params[:id])
  #   @users = @user.following.paginate(page: params[:page])　　←リレーションのモデル名間違っていました。userモデル参照。
  #   render 'show_follow'　　　　　　　　　　↑.pagenateというメソッドはgemが必要なので、現段階では使えません。（テキストには出てこない）
  # end

  # def followers
  #   @title = "Followers"
  #   @user  = User.find(params[:id])
  #   @users = @user.followers.paginate(page: params[:page])
  #   render 'show_follow'
  # end
  
  # 以下が修正後のもの（比較して下さい）
  
  def followings
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.follower_users
    render 'show_follow'
  end
    
  def update
    @user = User.find(params[:id])
    if current_user == @user && @user.update_attributes(user_params)
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