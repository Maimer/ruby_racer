require 'gosu'
require 'pry'
require_relative 'player'
require_relative 'tower'
require_relative 'tile'
require_relative 'timer'

class Falldown < Gosu::Window
  SCREEN_WIDTH = 1088
  SCREEN_HEIGHT = 1024

  attr_reader :tower, :large_font, :state

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)

    @tower = Tower.new(self)
    @song = Gosu::Song.new(self, 'theme.mp3')
    @timer = Timer.new
    @player = Player.new(self, @tower.brick)
    @large_font = Gosu::Font.new(self, "Arial", screen_height / 6)
    @small_font = Gosu::Font.new(self, "Arial", screen_height / 15)
    @state = :running
    @music = true
    @movement = 0
  end

  def update
    @music == true ? @song.play : @song.pause
    if button_down(Gosu::KbS)
      if @music == true
        @music = false
      elsif @music == false
        @music = true
      end
    end
    if @player.dead?
      @state = :lost
    end
    if @state != :lost
      if button_down?(Gosu::KbLeft)
        if state == :running
          @player.move_left(@tower.board, @tower.offset)
          @movement += 1
          if @movement > 35 then @movement = 1 end
        end
      elsif button_down?(Gosu::KbRight)
        if state == :running
          @player.move_right(@tower.board, @tower.offset)
          @movement += 1
          if @movement > 35 then @movement = 1 end
        end
      else
        @movement = 0
      end
      @tower.update(@timer.seconds, @timer.frames)
      @timer.update
      @player.floor_contact(@tower.board, @tower.offset, SCREEN_HEIGHT)
    end
    if button_down?(Gosu::KbSpace)
      if state == :running
        @player.jump(@tower.speed)
      end
    end
    if button_down?(Gosu::KbEscape)
      close
    end
    if button_down?(Gosu::KbR)
      if state != :running
        reset
      end
    end
  end

  def draw
    draw_rect(0, 0, screen_width, screen_height, Gosu::Color::BLACK)
    draw_text(15, 5, "#{@timer.seconds}", @small_font)
    @player.draw(@movement)
    @tower.board.each do |tile|
      tile.draw(@tower.offset, @tower.speed)
    end

    if @state == :lost
      draw_text_centered("game over", large_font)
    end
  end

  def reset
    @tower = Tower.new(self)
    @song = Gosu::Song.new(self, 'theme.mp3')
    @timer = Timer.new
    @player = Player.new(self, @tower.brick)
    @state = :running
  end

  def draw_rect(x, y, width, height, color)
    draw_quad(x, y, color,
      x + width, y, color,
      x + width, y + height, color,
      x, y + height, color)
  end

  def draw_text(x, y, text, font)
    font.draw(text, x, y, 3, 1, 1, Gosu::Color::RED)
  end

  def draw_text_centered(text, font)
    x = (screen_width - font.text_width(text)) / 2
    y = (screen_height - font.height) / 2 - 12

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
