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
    describe '#single_mode_name_sign' do
      it 'informs of mode, asks for user name and sign and returns them' do
        allow(displayer).to receive(:single_mode_name_sign).and_return(["Justyna\n", "J\n"])
        expect(displayer.single_mode_name_sign).to eq(["Justyna\n", "J\n"])
      end
    end
    describe '#multi_mode_names' do
      it 'informs of mode, asks for users names and returns them in an array' do
        allow(displayer).to receive(:multi_mode_names).and_return(["Justyna\n", "Kota\n"])
        expect(displayer.multi_mode_names).to eq(["Justyna\n", "Kota\n"])
      end
    end
    describe '#computer_mode' do
      it 'informs of mode, informs the user of computers names' do
        expect{displayer.computer_mode}.to output("You've picked the computer vs computer\nThe computers will be named: Computer 1 and Computer 2\n").to_stdout
      end
    end
  end

  context 'Picking order' do
    describe '#display_order_information' do
      it 'asks who should start' do
        expect{displayer.display_order_information("Justyna", "Igor")}.to output("If Justyna shall start enter 1, if Igor shall start enter 2\n").to_stdout
      end
    end
  end

  context 'Picking up the signs' do
    describe '#get_signs' do
      it 'asks for users signs and returns them in an array' do
        allow(displayer).to receive(:get_signs).with(:Justyna, :Kota).and_return(["J\n", "K\n"])
        expect(displayer.get_signs(:Justyna, :Kota)).to eq(["J\n", "K\n"])
      end
    end
  end


end
