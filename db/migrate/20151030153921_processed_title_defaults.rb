class ProcessedTitleDefaults < ActiveRecord::Migration
  
  def up
	Book.all.each do |t|
		t.update_attribute :processed_title, t.set_processed_title!  
  	end
  end

  def down
  	Book.all.each do |t|
  		t.update_attribute :processed_title, nil
  	end
  end

end
