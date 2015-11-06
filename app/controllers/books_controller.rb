class BooksController < ApplicationController

  helper_method :sort_column, :sort_direction
  
  def index
    @books = if params[:author]
      Book.where(author: params[:author]).order(ordering)
    elsif params[:title]
      @books = params[:title]
      Book.where(title: params[:title]).order(ordering)
    else
      Book.order(ordering)
    end
  end

  def show
  end

  def new
  end

  def create    
    @book = Book.new(book_params)
    if @book.valid?
      @book.save
    else
      flash[:notice] = @book.errors.full_messages.join(' - ') 
    end
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

  def search
    redirect_to(:action => 'index', author: params[:search][:author])
  end


  private
    
    def book_params
      params.require(:book).permit(:title, :processed_title, :position, :author, :physical, :ebook, :read)
    end

    def ordering
      "#{sort_column} #{sort_direction}"
    end

    def sort_column
      Book.column_names.include?(params[:sort]) ? params[:sort] : "author"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "ASC"
    end

end
