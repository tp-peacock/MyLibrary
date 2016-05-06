class RemovePositionFromBooks < ActiveRecord::Migration
  
  def change
    remove_column :books, :position
  end

end