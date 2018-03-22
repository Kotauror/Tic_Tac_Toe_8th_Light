require_relative "game"
require_relative "player"
require_relative "board"
require_relative "displayer"

def start_game
  @game = Game.new
  @displayer = Displayer.new
  @displayer.welcome
  game_mode
end

def game_mode
  @displayer.display_mode_information
  set_mode(STDIN.gets.chomp)
end

start_game
