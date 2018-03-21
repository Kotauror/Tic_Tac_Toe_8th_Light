require_relative 'board'

class Game

  attr_reader :mode, :player1, :player2, :active_player, :opponent, :board

  def initialize
    @mode = nil
    @player1 = nil
    @player2 = nil
    @active_player = nil
    @opponent = nil
    @board = Board.new
  end

  def set_up_mode(string)
    @mode = string
  end

end
