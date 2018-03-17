class Hola
  class << self
  	def hi(language = "english")
  	  translator = Translator.new(language)
  	  translator.hi
  	end
  end
end

require 'hola/translator'