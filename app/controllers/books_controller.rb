class BooksController < ApplicationController

  layout false

  def index

    @books = Book.order(params[:sort])
  end

  def show
  end

  def new
  end

  def create
    @book = Book.new(book_params)
    @book.save
    redirect_to(:action => 'index')
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      redirect_to(:action => 'index')
    else
      render('edit')
    end
  end

  def delete
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to(:action => 'index')
  end

  private
    
    def book_params
      params.require(:book).permit(:title, :position, :author, :physical, :ebook, :read)
    end

end
