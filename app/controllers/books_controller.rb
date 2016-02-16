class BooksController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :create, :destroy, :search]

  helper_method :sort_column, :sort_direction

  def index
    if params[:search].present?
      @books = current_user.books.where('author LIKE ?', '%' + params[:search] + '%')
      @books += current_user.books.where('title LIKE ?', '%' + params[:search] + '%')
   
    elsif params[:filter].present?
      
      filter_code_array = []
      if params[:filter][0] == "1"
        filter_code_array.push("physical")
      end
      if params[:filter][1] == "1"
        filter_code_array.push("ebook")
      end
      if params[:filter][2] == "1"
        filter_code_array.push("read")
      end
      
      @books = []
      id_holder = []
      current_user.books.each do |book|
        id_holder.push(book.id)
      end 

      current_user.books.each do |book|
        if filter_code_array.include?("physical") && book.physical == false
          id_holder.delete(book.id)
        end
        if filter_code_array.include?("ebook") && book.ebook == false
          id_holder.delete(book.id)
        end
        if filter_code_array.include?("read") && book.read == false
          id_holder.delete(book.id)
        end
        if filter_code_array.empty? && book.physical == false && book.ebook == false && book.read == false
          id_holder = []
          id_holder.push(book.id)
        end
      end

      id_holder.each do |id|
          @books += current_user.books.where(:id => id)
      end

    else
      @books = current_user.books.order(ordering)
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
