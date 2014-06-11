class Player
  attr_reader :x, :y, :icon, :bombs
  attr_writer :bomb
  def initialize(window, tile)
    @window = window
    @coin_pickup = Gosu::Sample.new(@window, 'music/coin.mp3')
    @bomb_drop = Gosu::Sample.new(@window, 'music/bomb.wav')
    @icon = Gosu::Image.new(@window, "runright/playerright.png", true)
    @iconleft = Gosu::Image.new(@window, "runleft/playerleft.png", true)
    @fallright = Gosu::Image.new(@window, "runright/fallright.png", true)
    @fallleft = Gosu::Image.new(@window, "runleft/fallleft.png", true)
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
    @falling = false
    @accel = 1
    @bombs = []
  end

  def jump(speed)
    if @falling == false
      @accel = -10 - speed
      @falling = true
    end
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
    if @x < 0 then @x = 0 end
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
    if @x > @window.width - @icon.width then @x = @window.width - @icon.width end
  end

  def floor_contact(board, offset, height)
    if @falling == true
      @accel += 1
    else
      @accel = 1
    end
    @y += 1 * @accel
    @falling = true
    board.each do |tile|
      if (tile.y + offset) > @y && (tile.y + offset) - @y < @icon.height
        if tile.x > 0 && tile.x < @window.width - @tile.width
          if tile.x > @x - @tile.width && tile.x < @x + @icon.width
            @y = (tile.y + offset) - @icon.height - 1
            @falling = false
          end
        end
      end
    end

    if @y > height - @icon.height
      @y = height - @icon.height
      @falling = false
    end
  end

  def draw(movement)
    if @direction == 1
      if @falling == true
        @fallright.draw(@x - 10, @y, 5)
      elsif movement == 0
        @icon.draw(@x, @y, 2)
      else
        num = ((movement - 1) / 3)
        @runright[num].draw(@x - 10, @y, 5)
      end
    elsif @direction == -1
      if @falling == true
        @fallleft.draw(@x - 10, @y, 5)
      elsif movement == 0
        @iconleft.draw(@x, @y, 2)
      else
        num = ((movement - 1) / 3)
        @runleft[num].draw(@x - 10, @y, 5)
      end
    end
  end

  def dead?
    @y < -@icon.height
  end

  def collect_coins(coins, offset, sfx)
    if coins.reject! { |coin| Gosu::distance(@x, @y + 24, coin.x, coin.y + offset) < 50 } then
      if sfx == true
        @coin_pickup.play(0.4)
      end
      return true
    end
    false
  end

  def drop_bomb(board, offset, sfx)
    @bombs << Bomb.new(@window, @x, @y + @icon.height)
    if sfx == true
      @bomb_drop.play(0.3)
    end
    board.reject! { |tile| Gosu::distance(@bombs[-1].x, @bombs[-1].y, tile.x, tile.y + offset) < 80 }
  end
end
