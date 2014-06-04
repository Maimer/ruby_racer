class Player
  def initialize(window)
    @window = window
    @icon = Gosu::Image.new(@window, "player.png", true)
    @x = (window.width / 2) - 17
    @y = (window.height / 2)

  end

  def move_left
    @x = @x - 1
    if @x < 0
      @x = 0
    end
  end

  def move_right
    @x = @x + 1
    if @x > @window.width - 34
      @x = @window.width - 34
    end
  end

  def draw
    @icon.draw(@x, @y, 1)
  end

  def dead?
    @y == 0
  end
end
