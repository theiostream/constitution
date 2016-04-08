require 'nokogiri'
require 'open-uri'

require_relative 'law_unit'
require_relative 'constitution_links'
require_relative 'artigo'

class Constitution < LawUnit
	def initialize(base)
		super
		@type = 'Constituição'
		@child_type = 'Artigo'
	end

	def list_children 
		# Let's assign the preamble as the Constitution's caput, even though this is juridically inaccurate.
		@caput = Artigo.new(@base.xpath("//p[@class='preambulo']").to_s, true)
		
		content = @base.xpath("//div[@id='content']").to_s
		content.split('Art.').drop(1).each do |art|
			@children << Artigo.new(art, false)
		end
	end
end
