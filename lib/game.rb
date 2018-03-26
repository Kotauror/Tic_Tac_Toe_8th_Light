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
    @round = 0
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

  def game_play
    while !@board.is_game_won? && !@board.is_tie?  do
      @displayer.show_board(@board.values, @player1.sign, @player2.sign)
      if @active_player.is_a? Human
        picked_number = @displayer.ask_for_number(@active_player, @board)
      else
        picked_number = @active_player.select_number(@board, @opponent.sign)
      end
      displayer.inform_of_move(@active_player, picked_number)
      @board.put_sign_on_board(@active_player.sign, picked_number)
      switch_active_player
    end
    @displayer.show_board(@board.values, @player1.sign, @player2.sign)
    displayer.final_score_annoncement(@board, @opponent)
  end

  def switch_active_player
    current_active = @active_player
    current_opponent = @opponent
    @opponent = current_active
    @active_player = current_opponent
  end

end
