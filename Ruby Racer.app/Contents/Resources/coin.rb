class Coin
  attr_reader :x, :y
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
  end

  def draw(offset, coins)
    img = coins[Gosu::milliseconds / 60 % coins.size]
    if @y + offset > -64 && @y + offset < @window.height + 64
      img.draw(@x, @y + offset, 1)
    end
  end
end
