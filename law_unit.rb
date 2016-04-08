class LawUnit
	attr_reader :text
	attr_reader :caput
	attr_reader :children
	
	attr_reader :type
	attr_reader :child_type

	attr_reader :amendments

	def initialize(base)
		@base = base
		
		@children = Array.new
		list_children

		@amendments = Array.new
		@text = make_text
	end

	def add_amendment(amendment)
		@amendments << amendment
	end

	def list_children()
		nil
	end

	def make_text()
		nil
	end
end
