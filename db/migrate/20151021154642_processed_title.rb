class ProcessedTitle < ActiveRecord::Migration
 
  def up
  	change_table :books do |t|
  		t.string "processed_title"
  	end
  end

  def down
  	remove_column :books, :processed_title 
  end

end
