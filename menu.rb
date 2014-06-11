class Menu
  attr_writer :menu_action
  def initialize(window, music, sfx)
    @window = window
    @start_time = Gosu::milliseconds()
    @selection = 1
    @menu_action = nil
    @menu_font = Gosu::Font.new(@window, "Tahoma", @window.screen_height / 12)
    @maimer_font = Gosu::Font.new(@window, "Tahoma", @window.screen_height / 30)
    @menu_board = menu_board
    @music_value = "ON"
    @sfx_value = "ON"
    @title = Gosu::Image.new(@window, "tiles/title.png")
    @select_sound = Gosu::Sample.new(@window, 'music/menuselect.wav')
    @enter_sound = Gosu::Sample.new(@window, 'music/enter.mp3')
    @theme = Gosu::Song.new(@window, 'music/title.mp3')
    @music_vol = music
    @sfx_vol = sfx
  end

  def update
    @music_vol == true ? @theme.play : @theme.pause
    @menu_action
  end

  def draw(music, sfx, tiles, bg, coins)
    bg.draw(0, 0, 1)
    bg.draw(0, 622, 1)
    @title.draw(55, 60, 2)

    y = 0
    @menu_board.each do |row|
      x = 0
      row.each do |num|
        if num < 2 && num >= 0
          tiles[0].draw(x, y, 1)
        elsif num >= 2 && num < 4
          tiles[1].draw(x, y, 1)
        elsif num >= 4 && num < 6
          tiles[2].draw(x, y, 1)
        elsif num >= 6 && num < 8
          tiles[3].draw(x, y, 1)
        elsif num >= 8
          tiles[4].draw(x, y, 1)
        end
        x += 64
      end
      y += 64
    end

    @music_vol = music
    @sfx_vol = sfx

    music == true ? @music_value = "ON" : @music_value = "OFF"
    sfx == true ? @sfx_value = "ON" : @sfx_value = "OFF"

    hcolor = 0xffffd700
    scolor, mcolor, fcolor = 0xffc0c0c0, 0xffc0c0c0, 0xffc0c0c0
    @selection == 1 ? scolor = hcolor : scolor = 0xffc0c0c0
    @menu_font.draw("START GAME!", text_center("START GAME!"), 555, 3, 1, 1, scolor)
    @selection == 2 ? mcolor = hcolor : mcolor = 0xffc0c0c0
    @menu_font.draw("MUSIC: #{@music_value}", 375, 655, 3, 1, 1, mcolor)
    @selection == 3 ? fcolor = hcolor : fcolor = 0xffc0c0c0
    @menu_font.draw("SFX: #{@sfx_value}", 420, 755, 3, 1, 1, fcolor)

    img = coins[Gosu::milliseconds / 60 % coins.size]
    coinx, coiny = 300, 555
    if @selection == 1
      coinx = 280
      coiny = 583
    elsif @selection == 2
      coinx = 312
      coiny = 683
    elsif @selection == 3
      coinx = 357
      coiny = 783
    end
    img.draw(coinx, coiny, 2)

    @maimer_font.draw("Move: Left/Right Arrow  /  Jump: Spacebar  /  Bomb: Down Arrow", 148, 870, 3, 1, 1, 0xfff5f5f5)
    @maimer_font.draw("Created by Nicholas Lee | github.com/maimer", 262, 910, 3, 1, 1, 0xfff5f5f5)
  end

  def text_center(text)
    ((@window.width - @menu_font.text_width(text)) / 2)
  end

  def button_down(id)
    if id == Gosu::KbUp
      @selection -= 1
      if @selection < 1
        @selection = 3
      end
      if @sfx_vol == true
        @select_sound.play(0.4)
      end
    elsif id == Gosu::KbDown
      @selection += 1
      if @selection > 3
        @selection = 1
      end
      if @sfx_vol == true
        @select_sound.play(0.4)
      end
    elsif id == Gosu::KbReturn
      if @selection == 1
        @menu_action = "start"
        @music_vol = false
        @enter_sound.play(0.5)
      elsif @selection == 2
        @menu_action = "mtoggle"
      elsif @selection == 3
        @menu_action = "sfxtoggle"
      end
    end
  end

  def menu_board
    board = []
    row1 = []
    17.times do
      row1 << rand(10)
    end
    board << row1
    14.times do
      board << [rand(10)] + [-1] * 15 + [rand(10)]
    end
    row2 = []
    17.times do
      row2 << rand(10)
    end
    board << row2
  end
end
