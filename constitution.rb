require 'nokogiri'
require 'open-uri'

require_relative 'law_unit'
require_relative 'constitution_links'
require_relative 'artigo'
require_relative 'strip_html'

class Constitution < LawUnit
	def initialize(base)
		super
		@type = 'Constituição'
		@child_type = 'Artigo'
	end

	def list_children 
		# Let's assign the preamble as the Constitution's caput, even though this is juridically inaccurate.
		@caput = Artigo.new(@base.xpath("//p[@class='preambulo']").to_s, 0)
		
		content = @base.xpath("//div[@id='content']").to_s
		content.split('Art.').drop(1).each_with_index do |art, i|
			artigo = Artigo.new(art, i + 1)
			artigo.list_children

			@children << artigo
		end

		@children
	end

	def make_text
		output = ''
		#output = "PREÂMBULO. " + @caput.make_text
		@children.each do |child|
			output << "\n" << child.make_text
		end

		output.strip_html
	end
end
