# RUBY RACER

Created by Nicholas Lee

Ruby Racer is a 2D platformer that makes use of random level generation to make every game completely unique.  The goal of the game is to maneuver your character as to stay on the screen as long as possible and to generate the highest score.  The game begins with a board that slowly scrolls vertically, with the scrolling speed increasing every 10 seconds.  Once your character moves off the top of the screen the game is over.

There are multiple ways to increase your score and multiple strategies for success!  First, the score increases continually as the game goes on, but it increases at a higher rate the lower the player is on the screen.  The second way to increase your score is to collect coins!  There are randomly generated coins that provide a substantial point bonus when they are collected.  There is also a point multiplier that causes coins to be worth more the longer you have been playing.

Got yourself in a jam and don't want to lose the game?  Use your bombs to blast your way through the floor!  The player starts the game with a single bomb in their inventory, but for every 5 coins collected, the player is awarded another bomb.

## HIGH SCORES

High scores are automatically submitted and displayed on http://rubyracergame.herokuapp.com
To change the name that you want to be displayed on the site you must pass the name as an argument value on the command line when launching the game. Names with spaces must be put into quotes on the command line.  Alternatively, edit the line 14 in main.rb to whatever name you want!

EX: $ ruby main.rb Bob
EX: $ ruby main.rb "Boss Man"

## Game controls:

Move: Left Arrow / Right Arrow

Jump: Spacebar

Use Bomb: Down Arrow

Menu: M

Reset: R

Close: Escape

## Sample Gameplay Video:

<a href="http://www.youtube.com/watch?feature=player_embedded&v=-a--nl-LjCc
" target="_blank"><img src="http://img.youtube.com/vi/-a--nl-LjCc/0.jpg"
alt="Ruby Racer Sample Gameplay" border="10" /></a>

## Game Menu:

![Ruby Racer Menu](https://raw.githubusercontent.com/Maimer/ruby_racer/master/images/rubyracer3.png)

## Sample Level:

![Sample Level](https://raw.githubusercontent.com/Maimer/ruby_racer/master/images/rubyracer1.png)

## Using a Bomb:

![Using a Bomb](https://raw.githubusercontent.com/Maimer/ruby_racer/master/images/rubyracer2.png)

## Can You Make it to the Rainbow Level?

![Rainbow Level](https://raw.githubusercontent.com/Maimer/ruby_racer/master/images/rubyracer4.png)

*This game includes many images and sounds that are copyrighted by their respective owners.*

