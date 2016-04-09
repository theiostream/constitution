require_relative 'law_unit'
require_relative 'paragrafo'
require_relative 'strip_html'

class Artigo < LawUnit
	attr_reader :number
	
	def initialize(text, number)
		super(text)
		
		@type = 'Artigo'
		@child_type = 'Parágrafo'
		
		@base = @base.sub(/[0-9]+./, '').special_strip
		@number = number
	end

	def list_children()
		paragrafos = @base.split(/[^,]\s*§/)
		if paragrafos.size == 1
			paragrafos = @base.split('Parágrafo único.')
		end
		
		@caput = Paragrafo.new(paragrafos[0], Paragrafo::ParagrafoCaput, 0)
		@caput.list_children

		paragrafos.drop(1).each_with_index do |paragrafo, i|
			if paragrafos.size == 2
				type = Paragrafo::ParagrafoUnico
			else
				type = Paragrafo::ParagrafoNumerado
			end
			
			p = Paragrafo.new(paragrafo, type, i + 1)
			p.list_children
			@children << p
		end

		@children
	end

	def make_text()
		output = 'Art. ' + @number.to_s + (@number < 10 ? "º " : ". ")
		output << @caput.make_text
		@children.each do |child|
			output << "\n" << child.make_text
		end

		output.strip_html
	end
end
