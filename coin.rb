class Coin
  attr_reader :x, :y, :coin
  def initialize(window, x, y)
    @window = window
    @coin = Gosu::Image.new(@window, "tiles/coin/coin.png", true)
    @x = x
    @y = y
  end

  def draw(offset)
    if @y + offset > -64 && @y + offset < @window.height + 64
      @coin.draw(@x, @y + offset, 1)
    end
  end
end
