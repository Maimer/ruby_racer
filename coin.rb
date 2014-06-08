class Coin
  attr_reader :x, :y, :coin
  def initialize(window, x, y)
    @window = window
    @coins = Gosu::Image.load_tiles(@window, 'tiles/coin/cointiles.png', 48, 48, false)
    @x = x
    @y = y
  end

  def draw(offset)
    img = @coins[Gosu::milliseconds / 60 % @coins.size]
    if @y + offset > -64 && @y + offset < @window.height + 64
      img.draw(@x, @y + offset, 1)
    end
  end
end
