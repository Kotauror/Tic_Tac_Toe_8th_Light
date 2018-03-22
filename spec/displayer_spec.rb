require 'displayer'

describe Displayer do

  subject(:displayer) { described_class.new }
  context 'At the beginning of the game' do
    describe '#welcome' do
      it 'welcomes the user with the name of the game and the rules' do
        expect{displayer.welcome}.to output("----- ( T  i  c | - | T  a  c | - | T  o  e ) -----\nPut three signs in a row in order to win\n").to_stdout
      end
    end
  end

  context 'Setting mode, getting names' do
    describe '#display_mode_information' do
      it 'displayer information about available modes' do
        expect{displayer.display_mode_information}.to output("Enter 1 to pick human vs computer\nEnter 2 to pick human vs human\nEnter 3 to pick computer vs computer\n").to_stdout
      end
    end

    describe '#single_mode_name' do
      it 'informs of mode, asks for user name and returns it' do
        allow(displayer).to receive(:single_mode_name).and_return("Justyna\n")
        expect(displayer.single_mode_name).to eq("Justyna\n")
      end
    end

    describe '#multi_mode_names' do
      it 'informs of mode, asks for users names and returns them in an array' do
        allow(displayer).to receive(:multi_mode_names).and_return(["Justyna\n", "Kota\n"])
        expect(displayer.multi_mode_names).to eq(["Justyna\n", "Kota\n"])
      end
    end
  end


end
