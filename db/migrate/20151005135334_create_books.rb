class CreateBooks < ActiveRecord::Migration
  
  def up
    create_table :books do |t|
    	t.string "title"
    	t.string "author"
    	t.integer "position"
    	t.integer "format"
    	t.timestamps null: false
    end
  end

  def down
  	drop_table :books
  end

end
