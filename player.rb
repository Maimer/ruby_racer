class Player
  def initialize(window)
    @window = window
    @icon = Gosu::Image.new(@window, "player.png", true)
    @x = (window.width / 2) - 34
    @y = 112

  end

  def move_left
    @x = @x - 10
    if @x < 64
      @x = 64
    end
  end

  def move_right
    @x = @x + 10
    if @x > @window.width - 132
      @x = @window.width - 132
    end
  end

  def draw
    @icon.draw(@x, @y, 1)
  end

  def dead?
    @y == 0
  end
end
