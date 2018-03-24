class Board

  attr_reader :values

  def initialize
    @values = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  end

  def put_sign_on_board(active_player, picked_position)
    @values[picked_position.to_i - 1] = active_player.sign
  end

end
