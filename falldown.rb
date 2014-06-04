require 'gosu'
require_relative 'player'
require_relative 'tower'

class Falldown < Gosu::Window
  SCREEN_WIDTH = 1088
  SCREEN_HEIGHT = 1152

  attr_reader :tower, :large_font, :state

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)

    @tower = Tower.new(self)
    @player = Player.new(self)
    @large_font = Gosu::Font.new(self, "Arial", screen_height / 6)
    @state = :running
  end

  def update
    if @player.dead?
      @state = :lost
    end
    if button_down?(Gosu::KbLeft)
      if state == :running
        @player.move_left
      end
    end
    if button_down?(Gosu::KbRight)
      if state == :running
        @player.move_right
      end
    end
    if button_down?(Gosu::KbEscape)
      close
    end
    if button_down?(Gosu::KbR)
      if state == :running
        reset
      end
    end
    @tower.update
  end

  def draw
    draw_rect(0, 0, screen_width, screen_height, Gosu::Color::BLACK)
    @player.draw
    @tower.draw

    case state
    when :lost
      draw_text_centered("game over", large_font)
    end
  end

  def reset
    @tower = Tower.new()
    @state = :running
  end

  def draw_rect(x, y, width, height, color)
    draw_quad(x, y, color,
      x + width, y, color,
      x + width, y + height, color,
      x, y + height, color)
  end

  def draw_text(x, y, text, font)
    font.draw(text, x, y, 1, 1, 1, Gosu::Color::BLACK)
  end

  def draw_text_centered(text, font)
    x = (screen_width - font.text_width(text)) / 2
    y = (screen_height - font.height) / 2

    draw_text(x, y, text, font)
  end

  def screen_width
    width
  end

  def screen_height
    height
  end
end

game = Falldown.new
game.show
