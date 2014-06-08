class Tile
  attr_reader :x, :y
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
  end

  def draw(offset, speed, tiles)
    if @y + offset > -tiles[0].height && @y + offset < @window.height + tiles[0].height
    #   @tile5.draw(@x, @y + offset, 1)
    # end
      if speed <= 3
        tiles[0].draw(@x, @y + offset, 1)
      elsif speed == 4
        tiles[1].draw(@x, @y + offset, 1)
      elsif speed == 5
        tiles[2].draw(@x, @y + offset, 1)
      elsif speed == 6
        tiles[3].draw(@x, @y + offset, 1)
      elsif speed >= 7
        tiles[4].draw(@x, @y + offset, 1)
      # elsif speed > 7
      #   @tiles.sample.draw(@x, @y + offset, 1)
      end
    end
  end
end
