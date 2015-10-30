class FixProcessedTitle < ActiveRecord::Migration
 
  def up
  	remove_column :books, :processed_title 
  end

  def down
  	change_table :books do |t|
  		t.string "processed_title"
  	end
  end

end

