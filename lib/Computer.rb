require_relative 'player'

class Computer < Player

  def select_number(board)
    sleep(1)
    board.available_numbers.sample
  end

end
