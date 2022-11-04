class BooksController < ApplicationController
  
  def index
    @book = Book.new
    @books = Book.all
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.user_name = current_user.name
    if @book.save
      flash[:notice] = "投稿にsuccessfullyしました。"
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "更新にsuccessfullyしました。"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "削除にsuccessfullyしました。"
    redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
