class BooksController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :create, :destroy, :search]

  helper_method :sort_column, :sort_direction

  def index
    @books = if params[:author]
      current_user.books.where('author LIKE ?', '%' + params[:author] + '%').order(ordering)
    elsif params[:title]
      @books = params[:title]
      current_user.books.where('title LIKE ?', '%' + params[:title] + '%').order(ordering)
    elsif params[:read]
      @books = params[:read]
      current_user.books.where(read: params[:read]).order(ordering)
    elsif params[:physical]
      @books = params[:physical]
      current_user.books.where(physical: params[:physical]).order(ordering)
    elsif params[:ebook]
      @books = params[:ebook]
      current_user.books.where(ebook: params[:ebook]).order(ordering)
    else
      current_user.books.order(ordering)
    end
  end

  def show
  end

  def new
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

  def delete
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to(:action => 'index')
  end

  def search
    binding.pry
    if Book.where('title LIKE ?', '%' + params[:search][:query] + '%').exists?
      binding.pry
      redirect_to(:action => 'index', title: params[:search][:query], author: params[:search][:query])
    elsif Book.where('author LIKE ?', '%' + params[:search][:query] + '%').exists?
      binding.pry
      redirect_to(:action => 'index', author: params[:search][:query])
    end
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
