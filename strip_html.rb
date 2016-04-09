class String
	def special_strip
		self.gsub(/\A\p{Space}*|\p{Space}*\z/, '')
	end

	def strip_html
		self.gsub(/\<[^\>]*\>/, '').special_strip
	end
end
