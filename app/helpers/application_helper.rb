module ApplicationHelper
	
	def sortable(column, column_title = nil)
		column_title ||= column.titleize
 		direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
 		sort = column == "title" ? "processed_title" : column

 		link_to column_title, :sort => sort, :direction => direction
 	end

end
