require_relative 'player'
require_relative 'board'


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
    pick_4_when_possible(board)
    pick_winning_position(board)
    # jesli danym ruchem wygramy - daj tam
    # jesli danym ruchem wygra player - daj tam
    # zadne - random_move
  end

  def pick_4_when_possible(board)
    return 4 if board.values.include?("4")
  end

  def pick_winning_position(board)
    board.available_numbers.each { |available_cell|
      board.put_sign_on_board(self.sign, available_cell)
      if board.is_game_won?
        board.put_sign_on_board(available_cell, available_cell)
        return available_cell.to_i
      else
        board.put_sign_on_board(available_cell, available_cell)
      end
    }
  end

end
