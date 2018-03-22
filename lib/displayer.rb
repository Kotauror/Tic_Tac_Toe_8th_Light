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

  def single_mode_name
    puts "You've picked the human vs computer mode"
    puts "Enter your name"
    name = STDIN.gets.chomp
    return name
  end

  def multi_mode_names
    puts "You've picked the human vs human mode"
    puts "Enter the first name"
    name1 = STDIN.gets.chomp
    puts "Enter the second name"
    name2 = STDIN.gets.chomp
    return [name1, name2]
  end

  def computer_mode
    puts "You've picked the computer vs computer"
    puts "The computers will be named: Computer 1 and Computer 2"
  end

end
