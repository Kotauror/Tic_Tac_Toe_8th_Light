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

  def single_mode_info
    puts "You've picked the human vs computer mode"
    puts "Enter your name"
    name = STDIN.gets.chomp
    return name
  end

end
