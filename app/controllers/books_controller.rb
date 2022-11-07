class BooksController < ApplicationController
  
  def index
    @current_user = current_user
    @book = Book.new
    @books = Book.all
    @book_comments = BookComment.all
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.user_name = current_user.name
    if @book.save
      flash[:notice] = "successfully created"
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end
  
  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user == current_user
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @book_comments = BookComment.all
    @user = @book.user
    @current_user = current_user
  end
  
  def destroy
    @book = Book.find(params[:id])
    @user = @book.user
    if @user == current_user
    else
      redirect_to books_path
    end
    @book.destroy
    flash[:notice] = "successfully deleted."
    redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
