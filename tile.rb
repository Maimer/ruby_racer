class Tile
  attr_reader :x, :y, :tile
  attr_writer :y
  def initialize(window, x, y)
    @window = window
    @tile = Gosu::Image.new(@window, "brick.png", true)
    @x = x
    @y = y
  end

  def draw(offset)
    @tile.draw(@x, @y + offset, 1)
  end
end
