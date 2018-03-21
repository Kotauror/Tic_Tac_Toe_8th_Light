class Game

  attr_reader :mode, :player1, :player2, :active_player, :opponent

  def initialize
    @mode = nil
    @player1 = nil
    @player2 = nil
    @active_player = nil
    @opponent = nil
  end

end
