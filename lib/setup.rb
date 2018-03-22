require_relative "game"
require_relative "player"
require_relative "human"
require_relative "computer"
require_relative "board"
require_relative "displayer"

def start_game
  @game = Game.new
  @displayer = Displayer.new
  @displayer.welcome
  game_mode
  player_order
end

def game_mode
  @displayer.display_mode_information
  set_mode(STDIN.gets.chomp)
end

def set_mode(number)
  case number
  when "1"
    @game.set_up_mode("S")
    name = @displayer.single_mode_name
    @game.set_player_1(Human.new(name))
    @game.set_player_2(Computer.new("Computer"))
  when "2"
    @game.set_up_mode("M")
    names = @displayer.multi_mode_names
    @game.set_player_1(Human.new(names[0]))
    @game.set_player_2(Human.new(names[1]))
  when "3"
    @game.set_up_mode("C")
    @displayer.computer_mode
    @game.set_player_1(Computer.new("Computer 1"))
    @game.set_player_2(Computer.new("Computer 2"))
  else
    game_mode
  end
end

def player_order
  @displayer.display_order_information(@game.player1.name, @game.player2.name)
  set_order(STDIN.gets.chomp)
end

def set_order(number)
  case number
  when "1"
    puts "#{@game.player1.name} is starting"
    @game.set_active_player(@game.player1)
    @game.set_opponent(@game.player2)
  when "2"
    puts "#{@game.player2.name} is starting"
    @game.set_active_player(@game.player2)
    @game.set_opponent(@game.player1)
  else
    player_order
  end
end

start_game
