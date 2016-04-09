require_relative 'law_unit'
require_relative 'inciso'
require_relative 'strip_html'

class Paragrafo < LawUnit
	ParagrafoCaput = 0
	ParagrafoUnico = 1
	ParagrafoNumerado = 2
	
	attr_reader :number
	attr_reader :paragrafo_type

	def initialize(text, type, number)
		super(text)
		@type = 'Parágrafo'
		@child_type = 'Inciso'
		
		@paragrafo_type = type
		@number = number

		@base = @base.sub(/[0-9]+./, '').special_strip
	end

	def list_children()
		@base.split(/[IVXLCDM]+\s\-/).each_with_index do |inciso, i|
			if i == 0
				@caput = inciso.strip_html
			else
				i = Inciso.new(inciso, i)
				i.list_children

				@children << i
			end
		end

		@children
	end

	def make_text()
		if @paragrafo_type == ParagrafoCaput
			output = @caput
		elsif @paragrafo_type == ParagrafoUnico
			output = "Parágrafo único. " + @caput
		else
			output = "§ " + @number.to_s + (@number < 10 ? "º " : ". ") + @caput
		end
		
		@children.each do |child|
			output << "\n" << child.make_text
		end
		
		output.strip_html
	end
end
