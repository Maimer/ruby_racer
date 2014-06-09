class Tile
  attr_reader :x, :y
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
  end

  def draw(offset, speed, tiles)
    if @y + offset > -tiles[0].height && @y + offset < @window.height + tiles[0].height
      # if speed <= 3
      #   tiles[0].draw(@x, @y + offset, 1)
      # elsif speed == 4
      #   # 1788
      #   tiles[1].draw(@x, @y + offset, 1)
      # elsif speed == 5
      #   # 4219
      #   tiles[2].draw(@x, @y + offset, 1)
      # elsif speed == 6
      #   # 7290
      #   tiles[3].draw(@x, @y + offset, 1)
      # elsif speed >= 7
      #   # 10937
      #   tiles[4].draw(@x, @y + offset, 1)
      # end
      if y <= 2812
        tiles[0].draw(@x, @y + offset, 1)
      elsif y > 2812 && y <= 5307
        # -1830
        tiles[1].draw(@x, @y + offset, 1)
      elsif y > 5307 && y <= 8378
        # -4270
        tiles[2].draw(@x, @y + offset, 1)
      elsif y > 8378 && y <= 12025
        # -7320
        tiles[3].draw(@x, @y + offset, 1)
      elsif y > 12025
        # -10980
        tiles[4].draw(@x, @y + offset, 1)
      end
    end
  end
end
