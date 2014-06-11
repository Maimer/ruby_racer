require 'gosu'
require 'pry'
require_relative 'player'
require_relative 'tower'
require_relative 'tile'
require_relative 'timer'
require_relative 'coin'
require_relative 'background'
require_relative 'bomb'
require_relative 'menu'

class Falldown < Gosu::Window
  SCREEN_WIDTH = 1088
  SCREEN_HEIGHT = 1024

  attr_reader :large_font, :state

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = "Ruby Racer"

    @tower = Tower.new(self)
    @tiles = [Gosu::Image.new(self, "tiles/yellow.png", true),
              Gosu::Image.new(self, "tiles/purple.png", true),
              Gosu::Image.new(self, "tiles/blue.png", true),
              Gosu::Image.new(self, "tiles/green.png", true),
              Gosu::Image.new(self, "tiles/red.png", true)]
    @coins = Gosu::Image.load_tiles(self, "tiles/coin/cointiles.png", 48, 48, false)
    @bomb = Gosu::Image.new(self, "tiles/bomb.png", true)
    @explosion = Gosu::Image.load_tiles(self, "tiles/explosion.png", 64, 64, false)
    @song = Gosu::Song.new(self, ['music/theme1.mp3', 'music/theme2.mp3', 'music/theme3.mp3'].sample)
    @gameover = Gosu::Song.new(self, 'music/gameover.mp3')
    @background = Gosu::Image.new(self, "tiles/bg.png", true)
    @timer = Timer.new
    @player = Player.new(self, @tower.brick)
    @large_font = Gosu::Font.new(self, "Arial", screen_height / 6)
    @small_font = Gosu::Font.new(self, "Tahoma", screen_height / 16)
    @bomb_font = Gosu::Font.new(self, "Tahoma", screen_height / 14)
    @state = :menu
    @music = true
    @sfx = true
    @menu = Menu.new(self, @music, @sfx)
    @movement = 0
    @score = 0
    @bomb_count = 1
    @coin_count = 0
    @game_end = nil
  end

  def update
    if @state != :menu
      if @player.dead?
        @state = :lost
        if @game_end == nil
          @game_end = Timer.new
        end
        @game_end.update
        if @game_end.seconds == 10
          reset(:menu)
        end
      end

      if @state == :running
        @gameover.stop
        @music == true && @timer.seconds >= 1 ? @song.play : @song.pause
      elsif @state == :lost
        if @music == true && @game_end.seconds <= 5
          @gameover.play
        end
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
        if @player.collect_coins(@tower.coins, @tower.offset, @sfx)
          @score += 2000 * (@tower.speed - 2)
          @coin_count += 1
          if @coin_count % 5 == 0
            @bomb_count += 1
          end
        end
        @player.bombs.reject! { |bomb| Gosu::milliseconds - bomb.time > 280 }
      end

      if button_down?(Gosu::KbR)
        if state != :running
          reset(:running)
        end
      end

      if @state == :running
        @score += (@player.y + @player.icon.height) * @tower.speed / 200
      end
    else
      menu_action = @menu.update
      if menu_action == "start"
        @timer = Timer.new
        @state = :running
      elsif menu_action == "mtoggle"
        @music == true ? @music = false : @music = true
      elsif menu_action == "sfxtoggle"
        @sfx == true ? @sfx = false : @sfx = true
      end
      @menu.menu_action = nil
    end
    if button_down?(Gosu::KbEscape)
      close
    end
  end

  def draw
    if @state != :menu
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

      draw_rect(0, 0, 1088, 60, 0x77000000)
      draw_text(15, -10, "SCORE: #{@score}", @small_font, Gosu::Color::WHITE)
      floor_shift = 0
      floor_num = ((@tower.offset - @player.y) / -192).ceil
      if floor_num >= 100 then floor_shift = 28 else floor_shift = 0 end
      draw_text(846 - floor_shift, -10, "FLOOR: #{floor_num}", @small_font, Gosu::Color::WHITE)
      @bomb.draw(8, 952, 6)
      draw_text(65, 950, "x", @small_font, Gosu::Color::WHITE)
      draw_text(97, 945, "#{@bomb_count}", @bomb_font, Gosu::Color.argb(0xFFFF7400))

      if @state == :lost
        draw_text_centered("Game Over", large_font)
        draw_rect(0, 60, 1088, 1074, 0x77000000)
      end
    else
      @menu.draw(@music, @sfx, @tiles, @background, @coins)
    end
  end

  def button_down(id)
    if @state == :menu
      @menu.button_down(id)
    else
      if id == Gosu::KbS
        @music == true ? @music = false : @music = true
      end
      if id == Gosu::KbDown && @state == :running
        if @bomb_count > 0
          @player.drop_bomb(@tower.board, @tower.offset, @sfx)
          @bomb_count -= 1
        end
      end
      if id == Gosu::KbM
        @song.stop
        reset(:menu)
      end
    end
  end

  def reset(state)
    @tower = Tower.new(self)
    @timer = Timer.new
    @player = Player.new(self, @tower.brick)
    @song = Gosu::Song.new(self, ['music/theme1.mp3', 'music/theme2.mp3', 'music/theme3.mp3'].sample)
    @state = state
    @movement = 0
    @score = 0
    @bomb_count = 1
    @coin_count = 0
    @game_end = nil
    @menu = Menu.new(self, @music, @sfx)
  end

  def draw_rect(x, y, width, height, color)
    draw_quad(x, y, color,
      x + width, y, color,
      x + width, y + height, color,
      x, y + height, color, 2)
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
