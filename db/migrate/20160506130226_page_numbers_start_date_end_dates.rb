class PageNumbersStartDateEndDates < ActiveRecord::Migration
  
  def up
      add_column :books, :pages, :integer
      add_column :books, :start_date, :date
      add_column :books, :end_date, :date
  end

  def down
      remove_column :books, :pages
      remove_column :books, :start_date
      remove_column :books, :end_date
  end

end
