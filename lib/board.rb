class Board

  attr_reader :values

  def initialize
    @values = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  end

  def put_sign_on_board(active_player, picked_position)
    @values[picked_position.to_i - 1] = active_player.sign
  end

  def is_valid?(picked_number)
    # non-numeric-string.to_i == 0
    picked_number.to_i != 0 && @values.include?(picked_number)
  end

  def is_game_won?
    [values[0], values[1], values[2]].uniq.length == 1 ||
    [values[3], values[4], values[5]].uniq.length == 1 ||
    [values[6], values[7], values[8]].uniq.length == 1 ||
    [values[0], values[3], values[6]].uniq.length == 1 ||
    [values[1], values[4], values[7]].uniq.length == 1 ||
    [values[2], values[5], values[8]].uniq.length == 1 ||
    [values[0], values[4], values[8]].uniq.length == 1 ||
    [values[2], values[4], values[6]].uniq.length == 1
  end

  def is_tie?
    !is_game_won? && all_spots_taken?
  end

  private

  def all_spots_taken?
    # array1 - array2 == [elements from 1 missing in 2]
    (["1", "2", "3", "4", "5", "6", "7", "8", "9"] - @values).length == 9
  end

end
