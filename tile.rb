class Tile
  attr_reader :x, :y, :tile
  attr_writer :y
  def initialize(window, x, y)
    @window = window
    @tile1 = Gosu::Image.new(@window, "tiles/yellow.png", true)
    @tile2 = Gosu::Image.new(@window, "tiles/purple.png", true)
    @tile3 = Gosu::Image.new(@window, "tiles/blue.png", true)
    @tile4 = Gosu::Image.new(@window, "tiles/green.png", true)
    @tile5 = Gosu::Image.new(@window, "tiles/red.png", true)
    @tiles = [@tile1, @tile2, @tile3, @tile4, @tile5]
    @x = x
    @y = y
  end

  def draw(offset, speed)
    if @y + offset > -@tile5.height && @y + offset < @window.height + @tile5.height
    #   @tile5.draw(@x, @y + offset, 1)
    # end
      if speed == 2
        @tile1.draw(@x, @y + offset, 1)
      elsif speed == 3
        @tile2.draw(@x, @y + offset, 1)
      elsif speed == 4
        @tile3.draw(@x, @y + offset, 1)
      elsif speed == 5
        @tile4.draw(@x, @y + offset, 1)
      elsif speed == 6
        @tile5.draw(@x, @y + offset, 1)
      elsif speed > 6
        @tiles.sample.draw(@x, @y + offset, 1)
      end
    end
  end
end
