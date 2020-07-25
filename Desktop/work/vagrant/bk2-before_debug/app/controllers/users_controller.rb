class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    # if〜endを追加
    if @user == current_user
    else
    redirect_to user_path(current_user.id) #users#show
    end
  end

  def update
       @user = User.find(params[:id])
    if @user.update(user_params)
      # users_path(@user)user#indexをuser_path(@user.id)user#showへ変更→編集成功になる
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      # "show"を:edit に変更
      render :edit
    end
  end

# endを追加
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def following
     @user = User.find(params[:id])
    # user infoで表示されている人がフォローした人全員
     @users = @user.following_user
  end

  def followed
     @user = User.find(params[:id])
     # user infoで表示されている人のことをフォローした人全員
     @users = @user.follower_user
  end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end
end
