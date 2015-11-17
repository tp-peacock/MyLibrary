class ProcessedTitle4 < ActiveRecord::Migration
 
  def change
  	remove_column :books, :processed_title 
  	change_table :books do |t|
  		t.string "processed_title"
  	end
	Book.all.each do |t|
		t.update_attribute :processed_title, t.set_processed_title!  
  	end 
  end

end