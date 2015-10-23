class Book < ActiveRecord::Base

	STOP_WORDS = %w{the a}



	after_save{ set_processed_title! }

	scope :sorted, lambda {order("books.position ASC") }
	scope :alphabetical, lambda {order("books.title ASC") }

	def set_processed_title!
		first_word = title.split(' ').first
		if STOP_WORDS.include? first_word.downcase
			self.processed_title = title.sub(first_word, '').lstrip
		else 
			self.processed_title = title
		end	
	end

end
