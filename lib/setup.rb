require_relative "game"
require_relative "player"
require_relative "human"
require_relative "computer"
require_relative "board"
require_relative "displayer"

def start_setup
  @displayer = Displayer.new
  @game = Game.new(@displayer)
  @game.displayer.welcome
  set_player_mode
  player_order
  @game.displayer.set_up_ready
  start_game
end

def set_player_mode
  number = @game.displayer.set_player_mode
  case number
  when "1"
    @game.set_up_mode("S")
    user_data = @game.displayer.single_mode_name_sign
    @game.displayer.inform_of_computer_sing
    @game.set_player_1(Human.new(user_data[0], user_data[1]))
    @game.set_player_2(Computer.new("Computer", "#"))
  when "2"
    @game.set_up_mode("M")
    users_data = @game.displayer.multi_mode_names_signs
    @game.set_player_1(Human.new(users_data[0], users_data[1]))
    @game.set_player_2(Human.new(users_data[2], users_data[3]))
  when "3"
    @game.set_up_mode("C")
    @game.displayer.computer_mode
    @game.set_player_1(Computer.new("Computer 1", "C"))
    @game.set_player_2(Computer.new("Computer 2", "K"))
  else
    game_mode
  end
end

def player_order
  number = @game.displayer.get_order_information(@game.player1.name, @game.player2.name)
  case number
  when "1"
    @game.set_active_player(@game.player1)
    @game.set_opponent(@game.player2)
  when "2"
    @game.set_active_player(@game.player2)
    @game.set_opponent(@game.player1)
  end
end

def start_game
  @game.one_round
end

start_setup
