class Tower
  attr_reader :board, :brick, :offset, :speed
  def initialize(window)
    @window = window
    @brick = Gosu::Image.new(@window, "brick.png", true)
    @board = make_row([], 15, 0)
    @offset = 0
    @speed = 2
  end

  def update(seconds, frames)
    update_board
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
          board << Tile.new(@window, 1024, y)
          y += @brick.height
        end
      end
      row += 1
    end
    board
  end

  def update_board
    if @offset <= -(@brick.height * 3)
      19.times do
        @board.shift
      end
      @board.each do |tile|
        tile.y -= (@brick.height * 3)
      end
      make_row(@board, 3, 18 * @brick.height)
      @offset -= @offset
    end
  end
end
