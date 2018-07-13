require 'rounding'

class Apple 
	attr_reader = :x, :y
	def initialize
		@size = 10
		@x = rand(10..990).round_to(10)
		@y = rand(10..690).round_to(10)
	end
end