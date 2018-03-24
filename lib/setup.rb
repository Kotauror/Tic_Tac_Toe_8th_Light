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
  set_player_mode
  player_order
end

def set_player_mode
  number = @displayer.set_player_mode
  case number
  when "1"
    @game.set_up_mode("S")
    user_data = @displayer.single_mode_name_sign
    @game.set_player_1(Human.new(user_data[0], user_data[1]))
    @game.set_player_2(Computer.new("Computer", "C"))
  when "2"
    @game.set_up_mode("M")
    users_data = @displayer.multi_mode_names_signs
    @game.set_player_1(Human.new(users_data[0], users_data[1]))
    @game.set_player_2(Human.new(users_data[2], users_data[3]))
  when "3"
    @game.set_up_mode("C")
    @displayer.computer_mode
    @game.set_player_1(Computer.new("Computer 1", "C"))
    @game.set_player_2(Computer.new("Computer 2", "K"))
  else
    game_mode
  end
end

def player_order
  number = @displayer.get_order_information(@game.player1.name, @game.player2.name)
  case number
  when "1"
    @game.set_active_player(@game.player1)
    @game.set_opponent(@game.player2)
  when "2"
    @game.set_active_player(@game.player2)
    @game.set_opponent(@game.player1)
  end
end

start_game
