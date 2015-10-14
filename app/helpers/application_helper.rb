module ApplicationHelper
	
	def sortable(column, column_title = nil)
		column_title ||= column.titleize
 		direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
 		link_to column_title, :sort => column, :direction => direction
 	end

end
