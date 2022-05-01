module ApplicationHelper
	def uri_i?(string)
		uri = URI.parse(string)
		%w( http https ).include?(uri.scheme)
		# check if uri has jpg, png, gif, jpeg, bmp, tif, tiff, ico, svg, wbmp, ico, or gif via regex
		if string =~ /\.(jpg|png|gif|jpeg|bmp|tif|tiff|ico|svg|wbmp|ico|gif)$/
			return true
		else
			return false
		end
	rescue URI::BadURIError
		false
	rescue URI::InvalidURIError
		false
	end
end
