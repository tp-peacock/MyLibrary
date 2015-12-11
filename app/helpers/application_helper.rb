module ApplicationHelper
	
	def full_title(page_title = '')
    	base_title = "A Personal Library"
    	if page_title.empty?
      		base_title
    	else
      		page_title + " | " + base_title
    	end
  	end

	def sortable(column, column_title = nil)
		column_title ||= column.titleize
		sort = column == "title" ? "processed_title" : column
 		direction = (sort == sort_column && sort_direction == "asc") ? "desc" : "asc"
		author = params[:author]
		title = params[:title]
 		link_to column_title, :title => title, :author => author, :sort => sort, :direction => direction
 	end

end
