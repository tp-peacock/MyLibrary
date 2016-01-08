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

end
