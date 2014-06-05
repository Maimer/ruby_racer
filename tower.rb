class Tower
  attr_reader :board, :brick, :offset
  def initialize(window)
    @window = window
    @brick = Gosu::Image.new(@window, "brick.png", true)
    @board = make_board
    @offset = 0
  end

  def update
    update_board
    @offset -= 2
  end

  def draw
    @board.each_with_index do |row, i|
      row.each_with_index do |col, j|
        x = j * @brick.width
        y = @offset + i * @brick.width
        if col == 1
          @brick.draw(x, y, 1)
        end
      end
    end
  end

  def make_board
    newboard = []
    emptyrow = [1] + [0] * 15 + [1]
    10.times do
      make_row(newboard)
    end
    newboard
  end

  def make_row(board)
    emptyrow = [1] + [0] * 15 + [1]
    num = rand(14) + 1
    floorrow = [1] * 17
    floorrow[num] = 0
    floorrow[num + 1] = 0
    board << floorrow << emptyrow << emptyrow
  end

  def update_board
    if @offset <= -192
      3.times do
        @board.shift
      end
      make_row(@board)
      @offset += 192
    end
  end
end
