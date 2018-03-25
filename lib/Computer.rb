require_relative 'player'

class Computer < Player

  def select_number(board)
    num = [1,0].sample
    if num == 1
      return random_move(board)
    else
      return elaborate_move(board)
    end
  end

  def random_move(board)
    # board.available_numbers.sample
  end

  def elaborate_move(board)
  end

end
