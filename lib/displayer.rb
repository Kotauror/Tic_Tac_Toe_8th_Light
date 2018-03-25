require "colorize"


class Displayer

  def initialize
  end

  def welcome
    puts "----- ( T  i  c | - | T  a  c | - | T  o  e ) -----"
    puts "Put three signs in a row in order to win"
  end

  def set_player_mode
    puts "Enter 1 to pick human vs computer"
    puts "Enter 2 to pick human vs human"
    puts "Enter 3 to pick computer vs computer"
    while true do
      case mode = gets.chomp.to_s
      when "1"
        return mode
      when "2"
        return mode
      when "3"
        return mode
      else
        puts "Please enter 1, 2 or 3".red
      end
    end
  end

  def single_mode_name_sign
    puts "You've picked the human vs computer mode"
    ask_for_name_and_sign
  end

  def multi_mode_names_signs
    puts "You've picked the human vs human mode"
    puts "First player"
    user_one_data = ask_for_name_and_sign
    puts "Second player"
    user_two_data = ask_for_name_and_sign_seond_player(user_one_data)
    return user_one_data + user_two_data
  end

  def computer_mode
    puts "You've picked the computer vs computer"
    puts "The computers will be named: Computer 1 and Computer 2 and will have signs 'C' and 'K'"
  end

  def inform_of_computer_sing
    puts "The computer's sign will be #"
  end

  def get_order_information(name1, name2)
    puts "If #{name1} shall start enter 1, if #{name2} shall start enter 2"
    while true do
      case number = gets.chomp.to_s
      when "1"
        puts "#{name1} is starting"
        return number
      when "2"
        puts "#{name2} is starting"
        return number
      else
        puts "Please enter 1 or 2".red
      end
    end
  end

  def ask_for_name_and_sign
    puts "Enter name"
    name = gets.chomp
    puts "#{name}, enter one letter sign to identify you on the board eg. X or O"
    sign = single_game_sign_guard
    return [name, sign]
  end

  def ask_for_name_and_sign_seond_player(user_one_data)
    puts "Enter name"
    name = gets.chomp
    puts "#{name}, enter one letter sign to identify you on the board eg. X or O"
    sign = multi_game_sign_guard(user_one_data)
    return [name, sign]
  end

  def single_game_sign_guard
    while true do
      sign = gets.chomp
      if sign.length != 1
        puts "Please enter only one character".red
      elsif is_numeric?(sign)
        puts "Please don't enter numbers other than 0".red
      else
        return sign
      end
    end
  end

  def multi_game_sign_guard(user_one_data)
    while true do
      sign = gets.chomp
      if sign.length != 1 then
        puts "Please enter only one character".red
      elsif sign == user_one_data[1] then
        puts "Pleace enter character other than #{user_one_data[1]}".red
      elsif is_numeric?(sign) then
        puts "Please don't enter numbers other than 0".red
      else
        return sign
      end
    end
  end

  def set_up_ready
    puts "-------- Set up is ready! --------".light_blue
    puts "You'r game will start in".light_blue
    # sleep(1)
    puts "5".light_blue
    # sleep(1)
    puts "4".light_blue
    # sleep(1)
    puts "3".light_blue
    # sleep(1)
    puts "2".light_blue
    # sleep(1)
    puts "1".light_blue
    # sleep(1)
    system "clear"
  end

  def show_board(board_values, sign_1, sign_2)
    colored_cells = board_values.map { |one_cell|
      color_cell(one_cell, sign_1, sign_2)
    }
     puts "#{colored_cells[0]} | #{colored_cells[1]} | #{colored_cells[2]} \n===+===+===\n" +
       "#{colored_cells[3]} | #{colored_cells[4]} | #{colored_cells[5]} \n===+===+===\n" +
       "#{colored_cells[6]} | #{colored_cells[7]} | #{colored_cells[8]} \n"
  end

  def ask_for_number(active_player, board)
    puts "#{active_player.name}, pick a spot"
    while true do
      position = gets.chomp
      return position if board.is_valid?(position)
      puts "Put a number of a non-taken field".red
    end
  end

  def inform_of_move(active_player, picked_number)
    puts "#{active_player.name} picked #{picked_number}"
  end

  def color_cell(cell, sign_1, sign_2)
    if cell == sign_1 then
      return cell.light_blue
    elsif cell == sign_2 then
      return cell.light_green
    else
      return cell
    end
  end

  def is_numeric?(s)
    (1..9).to_a.include?(s.to_i)
  end

end
