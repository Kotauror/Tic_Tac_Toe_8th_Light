require_relative 'board'
require_relative 'displayer'

class Game

  attr_reader :mode, :player1, :player2, :active_player, :opponent, :board, :displayer

  def initialize(displayer)
    @mode = nil
    @player1 = nil
    @player2 = nil
    @active_player = nil
    @opponent = nil
    @board = Board.new
    @displayer = displayer
  end

  def set_up_mode(string)
    if string == "S" || string == "M" || string == "C" then
      @mode = string
    end
  end

  def set_player_1(object)
    @player1 = object
  end

  def set_player_2(object)
    @player2 = object
  end

  def set_active_player(object)
    @active_player = object
  end

  def set_opponent(object)
    @opponent = object
  end

  def one_round
    @displayer.show_board(@board.values)
    picked_number = @displayer.ask_for_number(@active_player, @board)
    @board.put_sign_on_board(@active_player, picked_number.to_i)
    if !@board.is_game_won? && !@board.is_tie? then
      switch_active_player
    end
  end

  def switch_active_player
    current_active = @active_player
    current_opponent = @opponent
    @opponent = current_active
    @active_player = current_opponent
  end

end
