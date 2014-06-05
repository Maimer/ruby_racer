class Player
  def initialize(window, tile)
    @window = window
    @icon = Gosu::Image.new(@window, "player.png", true)
    @tile = tile.width
    @x = (window.width / 2) - (@icon.width / 2)
    @y = (tile.height * 6) - @icon.height

  end

  def move_left
    @x = @x - 10
    if @x < @tile
      @x = @tile
    end
  end

  def move_right
    @x = @x + 10
    if @x > @window.width - (@icon.width + @tile)
      @x = @window.width - (@icon.width + @tile)
    end
  end

  def floor_contact?(board, offset, height)
    if board[(@y + @icon.height + 1 - offset) / @tile][@x / @tile] == 1 ||
       board[(@y + @icon.height + 1 - offset) / @tile][(@x + @icon.width) / @tile] == 1
      @y -= 2
    else
      @y += 4
      if @y > height - @icon.height
        @y = height - @icon.height
      end
    end
  end

  def draw
    @icon.draw(@x, @y, 1)
  end

  def dead?
    @y == 0
  end
end
