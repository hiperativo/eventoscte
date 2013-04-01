module ApplicationHelper
	def markdown string
		Maruku.new(string).to_html.html_safe
	end
end
