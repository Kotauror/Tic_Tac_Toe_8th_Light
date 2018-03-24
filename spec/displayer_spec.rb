require 'displayer'

describe Displayer do

  subject(:displayer) { described_class.new }
  let(:board) {double('board', :values => ["1", "2", "3", "4", "5", "6", "7", "8", "9"])}


  before do
    allow($stdout).to receive(:write)
  end

  context 'At the beginning of the game' do
    describe '#welcome' do
      it 'welcomes the user with the name of the game and the rules' do
        expect{displayer.welcome}.to output(
          "----- ( T  i  c | - | T  a  c | - | T  o  e ) -----\n" +
          "Put three signs in a row in order to win\n"
        ).to_stdout
      end
    end
  end

  context 'Setting mode, getting names' do
    describe '#set_player_mode' do
      it 'returns the chosen mode in case of valid input' do
        displayer.stub(:gets).and_return("1\n")
        expect(displayer.set_player_mode).to eq("1")
      end
      it 'In case of invalid input - asks again' do
        displayer.stub(:gets).and_return("5\n", "1\n")
        expect{displayer.set_player_mode}.to output(
          "Enter 1 to pick human vs computer\nEnter 2 to pick human vs human\n" +
          "Enter 3 to pick computer vs computer\n" +
          "\e[0;31;49mPlease enter 1, 2 or 3\e[0m\n"
        ).to_stdout
      end
    end
    describe '#inform_of_computer_sing' do
      it "informs the user in single mode of computer's sign" do
        expect{displayer.inform_of_computer_sing}.to output(
          "The computer's sign will be #\n"
        ).to_stdout
      end
    end
    describe '#single_mode_name_sign' do
      it 'asks for user name and sign and returns them on valid input' do
        displayer.stub(:gets).and_return("Justyna\n", "J\n")
        expect(displayer.single_mode_name_sign).to eq(["Justyna", "J"])
      end
      it 'In case of invalid input - asks again' do
        displayer.stub(:gets).and_return("Justyna\n", "JZ\n", "J\n")
        expect{displayer.single_mode_name_sign}.to output(
          "You've picked the human vs computer mode\nEnter name\n" +
          "Justyna, enter one letter sign to identify you on the board eg. X or O\n" +
          "\e[0;31;49mPlease enter only one character\e[0m\n"
        ).to_stdout
      end
    end
    describe '#multi_mode_names_signs' do
      it 'asks for users names and returns them in an array on valid input' do
        displayer.stub(:gets).and_return("Justyna\n", "J\n", "Kota\n", "K\n")
        expect(displayer.multi_mode_names_signs).to eq(["Justyna", "J", "Kota", "K"])
      end
      it 'In case of invalid input (too long string) - asks again' do
        displayer.stub(:gets).and_return("Justyna\n", "JZ\n", "J\n", "Kota\n", "K\n")
        expect{displayer.multi_mode_names_signs}.to output(
          "You've picked the human vs human mode\nFirst player\nEnter name\n" +
          "Justyna, enter one letter sign to identify you on the board eg. X or O\n" +
          "\e[0;31;49mPlease enter only one character\e[0m\n" +
          "Second player\nEnter name\n" +
          "Kota, enter one letter sign to identify you on the board eg. X or O\n"
        ).to_stdout
      end
      it 'In case of invalid input (same sign twice) - asks again' do
        displayer.stub(:gets).and_return("Justyna\n", "J\n", "Kota\n", "J\n", "K\n")
        expect{displayer.multi_mode_names_signs}.to output(
          "You've picked the human vs human mode\nFirst player\nEnter name\n" +
          "Justyna, enter one letter sign to identify you on the board eg. X or O\n" +
          "Second player\nEnter name\n" +
          "Kota, enter one letter sign to identify you on the board eg. X or O\n" +
          "\e[0;31;49mPleace enter character other than J\e[0m\n"
        ).to_stdout
      end
    end
    describe '#computer_mode' do
      it 'informs of mode, informs the user of computers names' do
        expect{displayer.computer_mode}.to output(
          "You've picked the computer vs computer\nThe computers will be named:" +
          " Computer 1 and Computer 2 and will have signs 'C' and 'K'\n"
        ).to_stdout
      end
    end
  end

  context 'Picking order' do
    describe '#get_order_information' do
      it 'picks the order when correct number provided' do
        displayer.stub(:gets).and_return("1")
        expect(displayer.get_order_information("Justyna", "Kota")).to eq("1")
      end
      it 'In case of invalid input - asks again' do
        displayer.stub(:gets).and_return("3", "1")
        expect{displayer.get_order_information("Justyna", "Kota")}.to output(
          "If Justyna shall start enter 1, if Kota shall start enter 2\n" +
          "\e[0;31;49mPlease enter 1 or 2\e[0m\nJustyna is starting\n"
        ).to_stdout
      end
    end
  end

  context 'Setup is ready' do
    describe '#set_up_ready' do
      it 'tells the setup is ready, counts down from 5 to 1 and cleans the terminal window' do
        allow(displayer).to receive(:sleep)
        expect{displayer.set_up_ready}.to output(
          "\e[0;94;49m-------- Set up is ready! --------\e[0m\n" +
          "\e[0;94;49mYou'r game will start in\e[0m\n\e[0;94;49m5\e[0m\n" +
          "\e[0;94;49m4\e[0m\n\e[0;94;49m3\e[0m\n\e[0;94;49m2\e[0m\n\e[0;94;49m1\e[0m\n"
        ).to_stdout
      end
    end
  end

  context 'Game is in progress' do
    describe '#show_board' do
      it 'shows the current state of board' do
        expect{displayer.show_board(board.values)}.to output(
          "1 | 2 | 3 \n===+===+===\n4 | 5 | 6 \n===+===+===\n7 | 8 | 9 \n"
        ).to_stdout
      end
    end
  end

end
