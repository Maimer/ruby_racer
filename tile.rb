class Tile
  attr_reader :x, :y
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
  end

  def draw(offset, tiles)
    if @y + offset > -tiles[0].height && @y + offset < @window.height + tiles[0].height
      if y <= 2812
        tiles[0].draw(@x, @y + offset, 1)
      elsif y > 2812 && y <= 5307
        tiles[1].draw(@x, @y + offset, 1)
      elsif y > 5307 && y <= 8378
        tiles[2].draw(@x, @y + offset, 1)
      elsif y > 8378 && y <= 12025
        tiles[3].draw(@x, @y + offset, 1)
      elsif y > 12025 && y <= 16192
        tiles[4].draw(@x, @y + offset, 1)
      elsif y > 16192
        num = self.object_id.to_s[-2].to_i
        if num < 2
          tiles[0].draw(@x, @y + offset, 1)
        elsif num >= 2 && num < 4
          tiles[1].draw(@x, @y + offset, 1)
        elsif num >= 4 && num < 6
          tiles[2].draw(@x, @y + offset, 1)
        elsif num >= 6 && num < 8
          tiles[3].draw(@x, @y + offset, 1)
        else
          tiles[4].draw(@x, @y + offset, 1)
        end
      end
    end
  end
end
