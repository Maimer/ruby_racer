class Background
  def initialize(window, y)
    @window = window
    @y = y
  end

  def draw(offset, image)
    if @y + offset > -image.height && @y + offset < @window.height + image.height
      image.draw(0, @y + offset, 0)
    end
  end
end
