require 'gosu'
require 'pry'
require_relative 'player'
require_relative 'tower'
require_relative 'tile'
require_relative 'timer'
require_relative 'coin'

class Falldown < Gosu::Window
  SCREEN_WIDTH = 1088
  SCREEN_HEIGHT = 1024

  attr_reader :tower, :large_font, :state

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = "Mega Tower Race Extreme 5000"

    @tower = Tower.new(self)
    @song = Gosu::Song.new(self, 'music/theme1.mp3') # 'music/theme2.mp3', 'music/theme3.mp3', 'music/theme4.mp3'].sample)
    @gameover = Gosu::Song.new(self, 'music/gameover1.mp3') # 'music/gameover2.mp3'].sample)
    @timer = Timer.new
    @player = Player.new(self, @tower.brick)
    @large_font = Gosu::Font.new(self, "Arial", screen_height / 6)
    @small_font = Gosu::Font.new(self, "Arial", screen_height / 20)
    @state = :running
    @music = true
    @movement = 0
    @score = 0
  end

  def update
    if @player.dead?
      @state = :lost
    end

    if @state == :running
      @music == true ? @song.play : @song.pause
    elsif @state == :lost
      if @music == true
        @gameover.play
      end
      @music = false
    end

    if button_down?(Gosu::KbS)
      @music = false
    end
    if button_down?(Gosu::KbD)
      @music = true
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
      if button_down?(Gosu::KbSpace)
        if state == :running
          @player.jump(@tower.speed)
        end
      end
      @tower.update(@timer.seconds, @timer.frames)
      @timer.update
      @player.floor_contact(@tower.board, @tower.offset, SCREEN_HEIGHT)
      @score += @player.collect_coins(@tower.coins, @tower.offset) * (@tower.speed - 2)
    end

    if button_down?(Gosu::KbEscape)
      close
    end

    if button_down?(Gosu::KbR)
      if state != :running
        reset
      end
    end
    if @state == :running
      @score += (@player.y + @player.icon.height) * @tower.speed / 200
    end
  end

  def draw
    draw_rect(0, 0, screen_width, screen_height, Gosu::Color::BLACK)
    draw_text(1030, 5, "#{@timer.seconds}", @small_font, Gosu::Color::WHITE)
    draw_text(15, 5, "SCORE: #{@score}", @small_font, Gosu::Color::WHITE)
    @player.draw(@movement)
    @tower.board.each do |tile|
      tile.draw(@tower.offset, @tower.speed)
    end
    @tower.coins.each do |coin|
      coin.draw(@tower.offset)
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

  def draw_text(x, y, text, font, color)
    font.draw(text, x, y, 3, 1, 1, color)
  end

  def draw_text_centered(text, font)
    x = (screen_width - font.text_width(text)) / 2
    y = (screen_height - font.height) / 2 - 12
    color = Gosu::Color::RED

    draw_text(x, y, text, font, color)
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
