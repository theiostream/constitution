require_relative 'law_unit'

class Item < LawUnit
	attr_reader :number
	
	def initialize(text, number)
		super(text)
		@type = 'Item'
		@child_type = nil

		@number = number
		@caput = @base
	end
end

