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
    board.available_numbers.sample
  end

  def elaborate_move(board)
    if board.values.include?("4")
      return 4
    end 
    # jesli ejst 4 - daj 4
    # jesli danym ruchem wygramy - daj tam
    # jesli danym ruchem wygra player - daj tam
    # zadne - random_move
  end

end
