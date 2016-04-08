require_relative 'law_unit'
require_relative 'item'

class Alinea < LawUnit
	attr_reader :letter
	
	def initialize(text, letter)
		super(text)
		@type = 'Alínea'
		@child_type = 'Item'

		@letter = letter
	end

	def list_children()
		@base.split(/[0-9]+\./).each_with_index do |item, i|
			if i == 0
				@caput = item
			else
				@children << Item.new(item, i)
			end
		end
	end
end

