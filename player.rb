class Player
  def initialize(window, tile)
    @window = window
    @icon = Gosu::Image.new(@window, "player.png", true)
    @tile = tile.width
    @x = (window.width / 2) - (@icon.width / 2)
    @y = (tile.height * 6) - @icon.height

  end

  def move_left(board, offset)
    # if board[(@y + @icon.height - 1 - offset) / @tile][@x / @tile] != 1
      @x = @x - 10
    # end
    if @x < @tile
      @x = @tile
    end
  end

  def move_right(board, offset)
    # if board[(@y + @icon.height - 1 - offset) / @tile][(@x + @icon.width) / @tile] != 1
      @x = @x + 10
    # end
    if @x > @window.width - (@icon.width + @tile)
      @x = @window.width - (@icon.width + @tile)
    end
  end

  def floor_contact?(board, offset, speed, height)
    if board[(@y + @icon.height + 1 - offset) / @tile][@x / @tile] == 1 ||
       board[(@y + @icon.height + 1 - offset) / @tile][(@x + @icon.width) / @tile] == 1
      @y -= speed
    else
      @y += speed * 2
      if @y > height - @icon.height
        @y = height - @icon.height
      end
    end
  end

  def draw
    @icon.draw(@x, @y, 1)
  end

  def dead?
    @y == -@icon.height
  end
end
