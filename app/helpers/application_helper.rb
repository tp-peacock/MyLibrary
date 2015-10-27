module ApplicationHelper
	
	def sortable(column, column_title = nil)
		column_title ||= column.titleize
		sort = column == "title" ? "processed_title" : column
 		direction = (sort == sort_column && sort_direction == "asc") ? "desc" : "asc"
 		link_to column_title, :sort => sort, :direction => direction
 	end
end
