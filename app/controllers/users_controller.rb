class UsersController < ApplicationController
  before_action :user_authenticate, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @current_user = current_user
    @new_book = Book.new
    @books = @user.books
  end

  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully updated."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  private

  def user_authenticate
    if User.find(params[:id]) != current_user
      redirect_to books_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
