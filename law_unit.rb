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
		@amendments = Array.new
	end

	def add_amendment(amendment)
		@amendments << amendment
	end

	def list_children()
		@children = Array.new
	end

	def make_text()
		@text = @base.to_s
	end
end
