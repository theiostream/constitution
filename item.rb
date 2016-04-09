require_relative 'law_unit'
require_relative 'strip_html'

class Item < LawUnit
	attr_reader :number
	
	def initialize(text, number)
		super(text)
		@type = 'Item'
		@child_type = nil

		@number = number
		@caput = @base
	end

	def make_text()
		@number + ". " + @caput.strip_html
	end
end

