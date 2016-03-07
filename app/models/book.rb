class Book < ActiveRecord::Base

	belongs_to :user

	STOP_WORDS = %w{the a}

	validates :title, presence: true
	validates :author, presence: true
	validates :user_id, presence: true

	after_validation :set_processed_title!	

	def set_processed_title!
		first_word = title.split(' ').first
		if STOP_WORDS.include? first_word.downcase
			self.processed_title = title.sub(first_word, '').lstrip.downcase
		else 
			self.processed_title = title.downcase
		end	
	end

	def self.search(user, params)
    books = user.books.where('author LIKE ?', '%' + params + '%')
    books += user.books.where('title LIKE ?', '%' + params + '%')
	  books.uniq
	end

	def self.filter(user, params)
    params = params - ['']

    if params.empty?
      user.books.select do |book|        
        !book.physical && !book.ebook && !book.read
      end
    else
      user.books.select do |book|
      	(!params.include?("physical") || book.physical) &&
				(!params.include?("ebook")    || book.ebook) && 
				(!params.include?("read")     || book.read) 
      end
    end
	end
end
