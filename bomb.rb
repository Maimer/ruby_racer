class Bomb
  attr_reader :x, :y, :time
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @offset = 0
    @time = Gosu::milliseconds
  end

  def draw(speed, explosion)
    img = explosion[(Gosu::milliseconds - @time) / 20 % explosion.size]
    img.draw(@x - 39, @y + @offset - 3, 6)
    img.draw(@x + 39, @y + @offset - 3, 6)
    @offset -= speed
  end
end
