class Tower
  attr_reader :board, :brick, :offset, :speed
  def initialize(window)
    @window = window
    @brick = Gosu::Image.new(@window, "tiles/red.png", true)
    @board = make_row([], 250, 0)
    @offset = 0
    @speed = 2
  end

  def update(seconds, frames)
    if seconds % 10 == 0 && frames == 0
      @speed += 1
    end
    @offset -= @speed
  end

  def make_row(board, rows, multiplier)
    y = multiplier
    row = 1
    rows.times do
      num = (rand(14) + 1) * @brick.width
      x = 0
      if row % 2 == 0
        17.times do
          board << Tile.new(@window, x, y) unless (x == num || x == num + @brick.width)
          x += @brick.width
        end
        y += @brick.height
      else
        2.times do
          board << Tile.new(@window, 0, y)
          board << Tile.new(@window, @window.width - @brick.width, y)
          y += @brick.height
        end
      end
      row += 1
    end
    board
  end
end
