require 'displayer'

describe Displayer do

  subject(:displayer) { described_class.new }

  describe '#welcome' do
    it 'welcomes the user with the name of the game and the rules' do
      expect{displayer.welcome}.to output("----- ( T  i  c | - | T  a  c | - | T  o  e ) -----\nPut three signs in a row in order to win\n").to_stdout
    end
  end

end
