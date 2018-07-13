require 'gosu'
require_relative 'player'
require_relative 'apple'

WIDTH = 700
HEIGHT = 700
MOVEMENT = 20
SPEED = 3
class Snake < Gosu::Window
	def initialize
		super(WIDTH, HEIGHT)
		self.caption = "Snake"

		@px = @py = 300
		@ox = @oy = @delay = @i = 0
		@ax = @ay = 200
		@size = 9
		@direction = "up"
		@tailX = [300, 300, 300, 300]
		@tailY = [300, 300, 300, 300]
		@nTail = 4
		@hit = false
		@tail = 5
	end

	def draw
		c = Gosu::Color::WHITE
		draw_quad(0, 0, c, 700, 0, c, 700, 700, c, 0, 700, c)

		c = Gosu::Color::GREEN
		draw_rect(@px, @py, 20, 20, c, 3)
		@nTail.times{
			distance = Gosu.distance(@px, @py, @tailX[@i], @tailY[@i])
			if distance > 1
				c = Gosu::Color::BLUE
				draw_rect(@tailX[@i], @tailY[@i], 20, 20, c, 2)
				@i += 1
				@i = 0 if @i >= @nTail
			else
				@i += 1
				@i = 0 if @i >= @nTail
				@hit = true
			end
		}
		
		c = Gosu::Color::RED
		draw_rect(@ax, @ay, 20, 20, c, 1)
	end


	def update
		@delay += 1
		if @delay > SPEED
			move(@direction)
			@delay = 0
		end

		if @hit == true
			@nTail = 4
			until @tailX.count == 4
				@tailX.pop
				@tailY.pop
			end
			@hit = false
		end
		distance = Gosu.distance(@px, @py, @ax, @ay)
		if distance < 1
			@ax = @ay = rand(0..690).round_to(20)
			@nTail += 3
			@tailX.push(@tailX.last + @px)
			@tailX.push(@tailX.last + @px)
			@tailX.push(@tailX.last + @px)
			@tailY.push(@tailY.last + @py)
			@tailY.push(@tailY.last + @py)
			@tailY.push(@tailY.last + @py)
		end
	end

	def move(direction)
			@ox = @px
			@oy = @py
			if direction == "right"
				if @px + @size + MOVEMENT >= 700
					@px = 0
				else
					@px += MOVEMENT
				end
			end
			if direction == "left"
				if @px <= 0
					@px = 700
					@px -= MOVEMENT
				else
					@px -= MOVEMENT
				end
			end
			if direction == "up"
				if @py <= 0
					@py = 700
					@py -= MOVEMENT
				else
					@py -= MOVEMENT
				end
			end
			if direction == "down"
				if @py + @size + MOVEMENT >= 700
					@py = 0
				else
					@py += MOVEMENT
				end
			end
			@tailX.unshift(@ox)
			@tailY.unshift(@oy)
			@tailX.pop
			@tailY.pop
	end

	def button_down(id)
		@direction = "left" if id == Gosu::KbLeft
		@direction = "right" if id == Gosu::KbRight
		@direction = "up" if id == Gosu::KbUp
		@direction = "down" if id == Gosu::KbDown
	end
end

window = Snake.new
window.show