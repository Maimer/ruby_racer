class Player
  def initialize(window, tile)
    @window = window
    @icon = Gosu::Image.new(@window, "player.png", true)
    @x = (window.width / 2) - (@icon.width / 2)
    @y = (tile.height * 3) - @icon.height

  end

  def move_left(wall)
    @x = @x - 10
    if @x < wall.width
      @x = wall.width
    end
  end

  def move_right(wall)
    @x = @x + 10
    if @x > @window.width - (@icon.width + wall.width)
      @x = @window.width - (@icon.width + wall.width)
    end
  end

  def floor_contact?(board)
    if board[@x / 64][(@y + 80) / 64] == 1 || board[(@x + 68) / 64][(@y + 80) / 64] == 1
      @y -= 2
    else
      @y += 4
    end
  end

  def draw
    @icon.draw(@x, @y, 1)
  end

  def dead?
    @y == 0
  end
end
