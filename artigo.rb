require_relative 'law_unit'
require_relative 'paragrafo'

class Artigo < LawUnit
	attr_reader :number
	
	def initialize(text, preamble)
		super(text)
		@type = 'Artigo'
		@child_type = 'Parágrafo'
		
		if !preamble
			@base.match(/[0-9]+/) { |number| @number = number }
		end
	end

	def list_children()
		paragrafos = @base.split('§')
		if paragrafos.size == 1
			paragrafos = @base.split('Parágrafo único.')
		end
		
		@caput = Paragrafo.new(paragrafos[0], Paragrafo::ParagrafoCaput, 0)

		paragrafos.drop(1).each_with_index do |paragrafo, i|
			if paragrafos.size == 1
				type = Paragrafo::ParagrafoUnico
			else
				type = Paragrafo::ParagrafoNumerado
			end

			@children << Paragrafo.new(paragrafo, type, i + 1)
		end
	end
end
