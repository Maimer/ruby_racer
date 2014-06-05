class Tower
  attr_reader :board, :brick, :offset, :speed
  def initialize(window)
    @window = window
    @brick = Gosu::Image.new(@window, "brick.png", true)
    @board = make_board
    @offset = 0
    @speed = 2
    @start_time = Time.now
  end

  def update
    update_board
    time_passage = (Time.now - @start_time).to_i
    # @offset -= @speed + (2 ** (time_passage / 10) / 100)
    @speed +=
    @offset -= @speed
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
    if @offset <= -(@brick.height * 3)
      3.times do
        @board.shift
      end
      make_row(@board)
      @offset += (@brick.height * 3)
    end
  end
end
