class SetCurrentBooksToUser < ActiveRecord::Migration
  
  def change
    Book.all.each do |t|
      t.update_attribute :user_id, 5
    end
  end

end
