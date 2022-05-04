module ApplicationHelper
	def uri?(url)
		if url =~ URI::regexp
			return true
		else
			return false
		end
	end

	def uri_i?(string)
		if uri?(string) && string =~ /\.(jpg|png|gif|jpeg|bmp|tif|tiff|ico|svg|wbmp|ico|gif)$/
			return true
		else
			return false
		end
	end
end
