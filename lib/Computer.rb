require_relative 'player'
require_relative 'board'

class Computer < Player

  def elaborate_move(board, opponent_sign)
    sleep(1)
    position = pick_5_when_possible(board)
    if position == nil then
      position = pick_winning_position(board)
      if position == nil then
        position = block_opponent(board, opponent_sign)
        if position == nil then
          position = pick_corner(board)
          if position == nil then
            position = random_move(board)
          end
        end
      end
    end
    return position
  end

  def pick_5_when_possible(board)
    return "5" if board.available_numbers.include?("5")
  end

  def pick_winning_position(board)
    board.available_numbers.each { |available_cell|
      board.put_sign_on_board(self.sign, available_cell)
      if board.is_game_won?
        best_move = available_cell
        board.put_sign_on_board(available_cell, available_cell)
        return best_move
      else
        board.put_sign_on_board(available_cell, available_cell)
      end
    }
    return nil
  end

  def block_opponent(board, opponent_sign)
    board.available_numbers.each { |available_cell|
      board.put_sign_on_board(opponent_sign, available_cell)
      if board.is_game_won?
        best_move = available_cell
        board.put_sign_on_board(available_cell, available_cell)
        return best_move
      else
        board.put_sign_on_board(available_cell, available_cell)
      end
    }
    return nil
  end

  def pick_corner(board)
    board.values.find { |num|
      num == "1" || num == "3" || num == "7" || num == "9"
    }
  end

  def random_move(board)
    board.available_numbers.sample
  end

end
