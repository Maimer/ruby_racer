class Player
  def initialize(window, tile)
    @window = window
    @icon = Gosu::Image.new(@window, "player.png", true)
    @iconleft = Gosu::Image.new(@window, "playerleft.png", true)
    @x = (window.width / 2) - (@icon.width / 2)
    @y = (tile.height * 6) - @icon.height
    @tile = tile
    @direction = 1
  end

  def move_left(board, offset)
    @direction = -1
    @x = @x - 10
    board.each do |tile|
      if Gosu::distance(tile.x, tile.y, @x, @y) < @tile.width
        @x = tile.x + @tile.width + 1
      end
    end
  end

  def move_right(board, offset)
    @direction = 1
    @x = @x + 10
    board.each do |tile|
      if Gosu::distance(tile.x, tile.y, @x, @y) < @tile.width
        @x = tile.x - @icon.width - 1
      end
    end
  end

  def floor_contact?(board, offset, speed, height)
    # @y -= speed
    # @y += speed * 2
    if @y > height - @icon.height
      @y = height - @icon.height
    end
  end

  def draw
    if @direction == 1
      @icon.draw(@x, @y, 1)
    elsif @direction == -1
      @iconleft.draw(@x, @y, 1)
    end
  end

  def dead?
    @y < -@icon.height
  end
end
