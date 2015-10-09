class AddRead < ActiveRecord::Migration
  
  def up
  	change_table :books do |t|
  		t.boolean "read", default: false
  	end
  	change_column_default(:books, :physical, false)
  	change_column_default(:books, :ebook, false)
  end

  def down
  	remove_column :books, :read
  	change_column_default(:books, :physical, nil)
  	change_column_default(:books, :ebook, nil)
  end

end
