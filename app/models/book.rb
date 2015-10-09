class Book < ActiveRecord::Base

	scope :sorted, lambda {order("books.position ASC") }
	scope :alphabetical, lambda {order("books.title ASC") }

end
