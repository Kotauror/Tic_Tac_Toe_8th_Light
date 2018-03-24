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
    sign = single_character_guard
    return [name, sign]
  end

  def ask_for_name_and_sign_seond_player(user_one_data)
    puts "Enter name"
    name = gets.chomp
    puts "#{name}, enter one letter sign to identify you on the board eg. X or O"
    sign = multi_game_sign_guard(user_one_data)
    return [name, sign]
  end

  def single_character_guard
    while true do
      sign = gets.chomp
      return sign if sign.length == 1
      puts "Please enter only one character".red
    end
  end

  def multi_game_sign_guard(user_one_data)
    while true do
      sign = gets.chomp
      if sign.length == 1 && sign != user_one_data[1] then
        return sign
      elsif sign.length != 1 then
        puts "Please enter only one character".red
      elsif sign == user_one_data[1] then
        puts "Pleace enter character other than #{user_one_data[1]}".red
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

  def show_board(b_values)
    puts "#{b_values[0]} | #{b_values[1]} | #{b_values[2]} \n===+===+===\n" +
    "#{b_values[3]} | #{b_values[4]} | #{b_values[5]} \n===+===+===\n" +
    "#{b_values[6]} | #{b_values[7]} | #{b_values[8]} \n"
  end

  def ask_for_position(active_player, board_values)
    puts "#{active_player.name}, pick a spot"
    while true do
      position = gets.chomp.to_s
      if board_values.include?(position) then
        return position
      else
        puts "This spot is not available".red
      end
    end
  end



end
