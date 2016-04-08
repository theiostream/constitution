require_relative 'law_unit'
require_relative 'alinea'

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
				@caput = alinea
			else
				@children << Alinea.new(alinea, (i+96).chr) # FIXME 'aa', 'ab' etc.
			end
		end
	end
end
