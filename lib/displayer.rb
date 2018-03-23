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
    puts "Enter your name"
    name = STDIN.gets.chomp
    puts "Enter one letter sign to identify you on the board eg. X or O"
    sign = STDIN.gets.chomp
    return [name, sign]
  end

  def multi_mode_names_signs
    puts "You've picked the human vs human mode"
    puts "Enter the first name"
    name1 = STDIN.gets.chomp
    puts "#{name1}, Enter one letter sign to identify you on the board eg. X or O"
    sign1 = STDIN.gets.chomp
    puts "Enter the second name"
    name2 = STDIN.gets.chomp
    puts "#{name2}, Enter one letter sign to identify you on the board eg. X or O"
    sign2 = STDIN.gets.chomp
    return [name1, name2, sign1, sign2]
  end

  def computer_mode
    puts "You've picked the computer vs computer"
    puts "The computers will be named: Computer 1 and Computer 2 and will have signs 'C' and 'K'"
  end

  def display_order_information(name1, name2)
      puts "If #{name1} shall start enter 1, if #{name2} shall start enter 2"
  end

  def display_sign_information(active, opponent)
    puts "Now it's a time to pick yous signs! Please enter one letter that will mark your moves on the board."
    puts "#{active.name}, enter your sign"
    sign_active = STDIN.gets.chomp
    puts "#{opponent.name}, enter your sign"
    sign_opponent = STDIN.gets.chomp
    return [sign_active, sign_opponent]
  end

end
