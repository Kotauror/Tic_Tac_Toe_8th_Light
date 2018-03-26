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
    puts "random"
    board.available_numbers.sample
  end

  def elaborate_move(board, opponent_sign)
    puts "elabo"
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
    puts "5 when possible"
    return "5" if board.available_numbers.include?("5")
  end

  def pick_winning_position(board)
    puts "pick winning"
    board.available_numbers.each { |available_cell|
      board.put_sign_on_board(self.sign, available_cell)
      if board.is_game_won?
        puts "game is won by us"
        best_move = available_cell
        board.put_sign_on_board(available_cell, available_cell)
        return best_move
      else
        puts "Game is not won by us"
        board.put_sign_on_board(available_cell, available_cell)
      end
    }
    return nil
  end

  def block_opponent(board, opponent_sign)
    puts "block opponent"
    board.available_numbers.each { |available_cell|
      board.put_sign_on_board(opponent_sign, available_cell)
      if board.is_game_won?
        puts "game is won by opponent"
        best_move = available_cell
        board.put_sign_on_board(available_cell, available_cell)
        return best_move
      else
        puts "game is not won by opponent"
        board.put_sign_on_board(available_cell, available_cell)
      end
    }
    return nil
  end

end
