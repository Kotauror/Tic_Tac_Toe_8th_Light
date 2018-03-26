require_relative 'player'
require_relative 'board'


class Computer < Player

  def select_number(board, opponent_sign)
    num = [1,0].sample
    if num == 1
      return random_move(board)
    else
      return elaborate_move(board, opponent_sign)
    end
  end

  def random_move(board)
    board.available_numbers.sample
  end

  def elaborate_move(board, opponent_sign)
    position = pick_5_when_possible(board)
    if position == nil then
      position = pick_winning_position(board)
      if position == nil then
        position = block_opponent(board, opponent_sign)
        if position == nil then
          position = random_move(board)
        end
      end
    end
    return position
  end

  def pick_5_when_possible(board)
    return 5 if board.values.include?("5")
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

  def block_opponent(board, opponent_sign)
    board.available_numbers.each { |available_cell|
      board.put_sign_on_board(opponent_sign, available_cell)
      if board.is_game_won?
        board.put_sign_on_board(available_cell, available_cell)
        return available_cell.to_i
      else
        board.put_sign_on_board(available_cell, available_cell)
      end
    }
  end

end
