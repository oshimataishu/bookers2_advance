class BooksController < ApplicationController

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorites).sort_by{|x| x.favorites.where(created_at: from...to).size}.reverse
    @current_user = current_user
    @new_book = Book.new
    @book_comments = BookComment.all
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    @new_book.user_name = current_user.name
    if @new_book.save
      flash[:notice] = "successfully created"
      redirect_to book_path(@new_book.id)
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
    @new_comment = BookComment.new
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
