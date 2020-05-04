class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
  	@books = Book.all
    @book_new = Book.new
  end

  def show
  	@book = Book.find(params[:id])
    @book_new = Book.new
    @user = User.find_by(id: @book.user_id)
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path
  end

  def create
     @books = Book.all
  	 @book_new = Book.new(book_params)
     @book_new.user_id = current_user.id
  	if @book_new.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book_new)
    else
      render :index
    end
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to books_path
  end
end

  def update
  	@book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "Book was successfully update."
       redirect_to book_path(@book)
    else
      render :edit
    end
  end

  private

  def book_params
	  params.require(:book).permit(:title, :body)
  end
end


