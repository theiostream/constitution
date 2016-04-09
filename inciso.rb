require_relative 'law_unit'
require_relative 'alinea'
require 'roman-numerals'
require_relative 'strip_html'

class Inciso < LawUnit
	attr_reader :number
	
	def initialize(text, number)
		super(text)
		@type = 'Inciso'
		@child_type = 'Alínea'

		@number = number
	end

	def list_children()
		@base.split(/[a-z]+\)/).each_with_index do |alinea, i|
			if i == 0
				@caput = alinea.strip_html
			else
				a = Alinea.new(alinea, (i+96).chr) # FIXME 'aa', 'ab' etc.
				a.list_children
				@children << a
			end
		end

		@children
	end

	def make_text()
		output = RomanNumerals.to_roman(@number) + " - " + @caput
		@children.each do |child|
			output << "\n" << child.make_text
		end

		output.strip_html
	end
end
