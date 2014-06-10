require 'gosu'
require 'pry'
require_relative 'player'
require_relative 'tower'
require_relative 'tile'
require_relative 'timer'
require_relative 'coin'
require_relative 'background'
require_relative 'bomb'

class Falldown < Gosu::Window
  SCREEN_WIDTH = 1088
  SCREEN_HEIGHT = 1024

  attr_reader :tower, :large_font, :state

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = "Super Mega Tower Race Extreme 5000"

    @tower = Tower.new(self)
    @tiles = [Gosu::Image.new(self, "tiles/yellow.png", true),
              Gosu::Image.new(self, "tiles/purple.png", true),
              Gosu::Image.new(self, "tiles/blue.png", true),
              Gosu::Image.new(self, "tiles/green.png", true),
              Gosu::Image.new(self, "tiles/red.png", true)]
    @coins = Gosu::Image.load_tiles(self, "tiles/coin/cointiles.png", 48, 48, false)
    @bomb = Gosu::Image.new(self, "tiles/bomb.png", true)
    @explosion = Gosu::Image.load_tiles(self, "tiles/explosion1.png", 64, 64, false)
    @song = Gosu::Song.new(self, ['music/theme1.mp3', 'music/theme2.mp3', 'music/theme3.mp3', 'music/theme4.mp3'].sample)
    @gameover = Gosu::Song.new(self, 'music/gameover1.mp3')
    @background = Gosu::Image.new(self, "tiles/bg2.png", true)
    @timer = Timer.new
    @player = Player.new(self, @tower.brick)
    @large_font = Gosu::Font.new(self, "Arial", screen_height / 6)
    @small_font = Gosu::Font.new(self, "Tahoma", screen_height / 16)
    @bomb_font = Gosu::Font.new(self, "Tahoma", screen_height / 14)
    @state = :running
    @music = true
    @movement = 0
    @score = 0
    @bomb_count = 1
    @coin_count = 0
  end

  def update
    if @player.dead?
      @state = :lost
    end

    if @state == :running
      @gameover.stop
      @music == true ? @song.play : @song.pause
    elsif @state == :lost
      if @music == true
        @gameover.play
      end
      @music = false
    end

    if @state != :lost
      if button_down?(Gosu::KbLeft)
        @player.move_left(@tower.board, @tower.offset)
        @movement += 1
        if @movement > 35 then @movement = 1 end
      elsif button_down?(Gosu::KbRight)
        @player.move_right(@tower.board, @tower.offset)
        @movement += 1
        if @movement > 35 then @movement = 1 end
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
      if @player.collect_coins(@tower.coins, @tower.offset)
        @score += 2000 * (@tower.speed - 2)
        @coin_count += 1
        if @coin_count % 5 == 0
          @bomb_count += 1
        end
      end
      @player.bombs.reject! { |bomb| Gosu::milliseconds - bomb.time > 280 }
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

    @player.draw(@movement)
    @tower.board.each do |tile|
      tile.draw(@tower.offset, @tiles)
    end
    @tower.coins.each do |coin|
      coin.draw(@tower.offset, @coins)
    end
    @tower.background.each do |bg|
      bg.draw(@tower.offset, @background)
    end
    if @player.bombs.size != 0
      @player.bombs.each do |bomb|
        bomb.draw(@tower.speed, @explosion)
      end
    end

    draw_text(15, -10, "SCORE: #{@score}", @small_font, Gosu::Color::WHITE)
    draw_text(846, -10, "FLOOR: #{((@tower.offset - @player.y) / -192).ceil}", @small_font, Gosu::Color::WHITE)
    @bomb.draw(8, 952, 6)
    draw_text(65, 950, "x", @small_font, Gosu::Color::WHITE)
    draw_text(97, 945, "#{@bomb_count}", @bomb_font, Gosu::Color.argb(0xFFFF7400))

    if @state == :lost
      draw_text_centered("Game Over", large_font)
    end
  end

  def button_down(id)
    if id == Gosu::KbS
      @music == true ? @music = false : @music = true
    end
    if id == Gosu::KbDown
      if @bomb_count > 0
        @player.drop_bomb(@tower.board, @tower.offset)
        @bomb_count -= 1
      end
    end
  end

  def reset
    @tower = Tower.new(self)
    @timer = Timer.new
    @player = Player.new(self, @tower.brick)
    @song = Gosu::Song.new(self, ['music/theme1.mp3', 'music/theme2.mp3', 'music/theme3.mp3', 'music/theme4.mp3'].sample)
    @state = :running
    @music = true
    @movement = 0
    @score = 0
    @bomb_count = 1
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
    y = (screen_height - font.height) / 2
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

Falldown.new.show
