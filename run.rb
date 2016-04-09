require_relative 'constitution'
require_relative 'constitution_links'
require 'nokogiri'

doc = Nokogiri::HTML(open(ConstitutionLinks::OriginalConstitution))
x = Constitution.new doc

x.list_children
puts x.make_text
