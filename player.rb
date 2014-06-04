class Player
  def initialize(window)
    @window = window
    @icon = Gosu::Image.new(@window, "player.png", true)
    @x = 0
    @y = 0
  end

  def move_left
    @x = @x - 1
    if @x < 0
      @x = 0
    end
  end

  def move_right
    @x = @x + 1
    if @x > @window.width - 50
      @x = @window.width - 50
    end
  end

  def draw
    @icon.draw(@x, @y, 1)
  end
end
