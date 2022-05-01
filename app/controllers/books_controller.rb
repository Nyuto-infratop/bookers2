class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    book_user = @book.user_id
    @user = User.find_by_id(book_user)
  end

  def edit
    user_id = Book.find(params[:id]).user_id
    if user_id == current_user.id
      @book = Book.find(params[:id])
    else
      redirect_to books_path
    end
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else 
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else 
      render :edit
    end
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
