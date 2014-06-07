class Player
  def initialize(window, tile)
    @window = window
    @icon = Gosu::Image.new(@window, "playerright.png", true)
    @iconleft = Gosu::Image.new(@window, "playerleft.png", true)
    @runright = []
    12.times do |i|
      @runright << Gosu::Image.new(@window, "runright/right#{i+1}.png", true)
    end
    @runleft = []
    12.times do |i|
      @runleft << Gosu::Image.new(@window, "runleft/left#{i+1}.png", true)
    end
    @x = (window.width / 2) - (@icon.width / 2)
    @y = (tile.height * 8) - @icon.height
    @tile = tile
    @direction = 1
  end

  def move_left(board, offset)
    @direction = -1
    @x = @x - 13
    board.each do |tile|
      if tile.x < @x && @x - tile.x < @tile.width
        if (tile.y + offset) > @y - @tile.height && (tile.y + offset) < @y + @icon.height
          @x = tile.x + @tile.width + 1
        end
      end
    end
  end

  def move_right(board, offset)
    @direction = 1
    @x = @x + 13
    board.each do |tile|
      if tile.x > @x && tile.x - @x < @icon.width
        if (tile.y + offset) > @y - @tile.height && (tile.y + offset) < @y + @icon.height
          @x = tile.x - @icon.width - 1
        end
      end
    end
  end

  def floor_contact(board, offset, speed, height)
    @y += 2 * speed
    board.each do |tile|
      if (tile.y + offset) > @y && (tile.y + offset) - @y < @icon.height
        if tile.x > 0 && tile.x < @window.width - @tile.width
          if tile.x > @x - @tile.width && tile.x < @x + @icon.width
            @y = (tile.y + offset) - @icon.height - 1
          end
        end
      end
    end

    if @y > height - @icon.height
      @y = height - @icon.height
    end
  end

  def draw(movement)
    if @direction == 1
      if movement == 0
        @icon.draw(@x, @y, 1)
      else
        num = (movement / 3) - 1
        @runright[num].draw(@x, @y, 1)
      end
    elsif @direction == -1
      if movement == 0
        @iconleft.draw(@x, @y, 1)
      else
        num = (movement / 3) - 1
        @runleft[num].draw(@x, @y, 1)
      end
    end
  end

  def dead?
    @y < -@icon.height
  end
end
