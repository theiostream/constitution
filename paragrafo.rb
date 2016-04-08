require_relative 'law_unit'
require_relative 'inciso'

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
	end

	def list_children()
		@base.split(/[IVXLCDM]+\s\-/).each_with_index do |inciso, i|
			if i == 0
				@caput = inciso
			else
				@children << Inciso.new(inciso, i)
			end
		end
	end
end
