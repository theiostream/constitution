require_relative 'law_unit'
require_relative 'item'
require_relative 'strip_html'

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
				@caput = item.strip_html
			else
				item = Item.new(item, i)
				item.list_children
				@children << item
			end
		end

		@children
	end

	def make_text()
		output = @letter + ") " + @caput.strip
		@children.each do |child|
			output << "\n" << child.make_text
		end

		output.strip_html
	end
end

