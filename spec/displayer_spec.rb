require 'displayer'

describe Displayer do

  subject(:displayer) { described_class.new }

  # before do
  #   allow($stdout).to receive(:write)
  # end

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
        subject.stub(:gets).and_return("Justyna\n", "J\n")
        expect(displayer.single_mode_name_sign).to eq(["Justyna", "J"])
      end
    end
    describe '#multi_mode_names_signs' do
      it 'informs of mode, asks for users names and returns them in an array' do
        subject.stub(:gets).and_return("Justyna\n", "J\n", "Kota\n", "K\n")
        expect(displayer.multi_mode_names_signs).to eq(["Justyna", "J", "Kota", "K"])
      end
    end
    describe '#computer_mode' do
      it 'informs of mode, informs the user of computers names' do
        expect{displayer.computer_mode}.to output("You've picked the computer vs computer\nThe computers will be named: Computer 1 and Computer 2 and will have signs 'C' and 'K'\n").to_stdout
      end
    end
  end

  context 'Picking order' do
    describe '#get_order_information' do
      it 'picks the order when correct number provided' do
        subject.stub(:gets).and_return("1")
        expect(displayer.get_order_information("Justyna", "Kota")).to eq("1")
      end
      it 'doesnt set the order on invalid input' do
        subject.stub(:gets).and_return("3", "1")
        expect{displayer.get_order_information("Justyna", "Kota")}.to output("If Justyna shall start enter 1, if Kota shall start enter 2\nPlease enter 1 or 2\nJustyna is starting\n").to_stdout
      end
    end
  end

end
