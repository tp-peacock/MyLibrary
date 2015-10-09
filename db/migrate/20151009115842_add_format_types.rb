class AddFormatTypes < ActiveRecord::Migration
  
  def up
  	change_table :books do |t|
  		t.boolean "physical"
  		t.boolean "ebook"
  	end
  	change_column :books, :format, :string
  end

  def down
  	remove_column :books, :physical
  	remove_column :books, :ebook
  	change_column :books, :format, :integer
  end

end
