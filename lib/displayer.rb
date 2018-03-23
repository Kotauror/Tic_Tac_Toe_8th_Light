require "colorize"


class Displayer

  def initialize
  end

  def welcome
    puts "----- ( T  i  c | - | T  a  c | - | T  o  e ) -----"
    puts "Put three signs in a row in order to win"
  end

  def display_mode_information
    puts "Enter 1 to pick human vs computer"
    puts "Enter 2 to pick human vs human"
    puts "Enter 3 to pick computer vs computer"
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
    user_two_data = ask_for_name_and_sign
    return user_one_data + user_two_data
  end

  def computer_mode
    puts "You've picked the computer vs computer"
    puts "The computers will be named: Computer 1 and Computer 2 and will have signs 'C' and 'K'"
  end

  def display_order_information(name1, name2)
      puts "If #{name1} shall start enter 1, if #{name2} shall start enter 2"
  end

  def ask_for_name_and_sign
    puts "Enter name"
    name = STDIN.gets.chomp
    puts "#{name}, enter one letter sign to identify you on the board eg. X or O"
    sign = single_character_guard
    return [name, sign]
  end

  def single_character_guard
    while true do
      sign = STDIN.gets.chomp
      if sign.length == 1 then
        return sign
      else
        puts "Please write only one character"
      end
    end
  end

end
