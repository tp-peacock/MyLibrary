class BooksController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :create, :destroy, :search]

  helper_method :sort_column, :sort_direction

  def index
    @books = if params[:search].present?
      Book.search(current_user, params[:search])
    elsif params[:filter].present?
      Book.filter(current_user, params[:filter])
    else
      current_user.books.order(ordering)
    end
  end

  def create    
    @book = current_user.books.build(book_params)
    if @book.valid?
      @book.save
      flash[:success] = "New book '" + @book.title + "' added to library!"
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
            flash[:success] = "Book '" + @book.title + "' successfully updated!"

    else
      render('edit')
            flash[:danger] = "Something went wrong and your book was not updated!"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to(:action => 'index')
  end

  def search
    if params[:search][:query]
      redirect_to(:action => 'index', search: params[:search][:query])
    end
  end

  def filter
    if params[:filter].present?
        filter_code = [params[:filter][:physical], params[:filter][:ebook], params[:filter][:read]]
        redirect_to(:action => 'index', filter: filter_code)
    end
  end


  private
    
    def book_params
      params.require(:book).permit(:title, :processed_title, :author, :physical, :ebook, :read)
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
