require 'displayer'

describe Displayer do

  subject(:displayer) { described_class.new }
  let(:board) {double('board', :values => ["1", "2", "3", "4", "5", "6", "7", "8", "9"])}
  let(:partialy_full_board) {double('board', :values => ["1", "J", "3", "4", "5", "6", "7", "8", "9"])}
  let(:active_player) {double('active player', :name => "justyna", :sign => "J")}
  let(:opponent) {double('opponent', :name => "kota", :sign => "K")}


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
      it 'returns the chosen mode in case of valid input - 1' do
        allow(displayer).to receive(:gets).and_return("1\n")
        expect(displayer.set_player_mode).to eq("1")
      end
      it 'returns the chosen mode in case of valid input - 2' do
        allow(displayer).to receive(:gets).and_return("2\n")
        expect(displayer.set_player_mode).to eq("2")
      end
      it 'returns the chosen mode in case of valid input - 3' do
        allow(displayer).to receive(:gets).and_return("3\n")
        expect(displayer.set_player_mode).to eq("3")
      end
      it 'in case of invalid input - asks again' do
        allow(displayer).to receive(:gets).and_return("5\n", "1\n")
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
    describe '#single_game_sign_guard' do
      it 'asks for user name and sign and returns them on valid input' do
        allow(displayer).to receive(:gets).and_return("J\n")
        expect(displayer.single_game_sign_guard).to eq("J")
      end
      it 'in case of invalid input (too long sign) - asks again' do
        allow(displayer).to receive(:gets).and_return("Justyna\n", "JZ\n", "J\n")
        expect{displayer.single_mode_name_sign}.to output(
          "You've picked the human vs computer mode\nEnter name\n" +
          "Justyna, enter one letter sign to identify you on the board eg. X or O\n" +
          "\e[0;31;49mPlease enter only one character\e[0m\n"
        ).to_stdout
      end
      it 'in case of invalid input (sign is numeric (1-9)) - asks again' do
        allow(displayer).to receive(:gets).and_return("Justyna\n", "7\n", "J\n")
        expect{displayer.single_mode_name_sign}.to output(
          "You've picked the human vs computer mode\nEnter name\n" +
          "Justyna, enter one letter sign to identify you on the board eg. X or O\n" +
          "\e[0;31;49mPlease don't enter numbers other than 0\e[0m\n"
        ).to_stdout
      end
      it 'in case of invalid input (computers sign) - asks again' do
        allow(displayer).to receive(:gets).and_return("Justyna\n", "#\n", "J\n")
        expect{displayer.single_mode_name_sign}.to output(
          "You've picked the human vs computer mode\nEnter name\n" +
          "Justyna, enter one letter sign to identify you on the board eg. X or O\n" +
          "\e[0;31;49mSorry, this sign will be used by the computer\e[0m\n"
        ).to_stdout
      end
    end
    describe '#multi_game_sign_guard' do
      it 'asks for users names and returns them in an array on valid input' do
        allow(displayer).to receive(:gets).and_return("Justyna\n", "J\n", "Kota\n", "K\n")
        expect(displayer.multi_mode_names_signs).to eq(["Justyna", "J", "Kota", "K"])
      end
      it 'in case of invalid input (too long string) - asks again' do
        allow(displayer).to receive(:gets).and_return("Justyna\n", "JZ\n", "J\n", "Kota\n", "K\n")
        expect{displayer.multi_mode_names_signs}.to output(
          "You've picked the human vs human mode\nFirst player\nEnter name\n" +
          "Justyna, enter one letter sign to identify you on the board eg. X or O\n" +
          "\e[0;31;49mPlease enter only one character\e[0m\n" +
          "Second player\nEnter name\n" +
          "Kota, enter one letter sign to identify you on the board eg. X or O\n"
        ).to_stdout
      end
      it 'in case of invalid input (sign is numeric(1-9)) - asks again' do
        allow(displayer).to receive(:gets).and_return("Justyna\n", "J\n", "Kota\n", "7\n", "K\n")
        expect{displayer.multi_mode_names_signs}.to output(
          "You've picked the human vs human mode\nFirst player\nEnter name\n" +
          "Justyna, enter one letter sign to identify you on the board eg. X or O\n" +
          "Second player\nEnter name\n" +
          "Kota, enter one letter sign to identify you on the board eg. X or O\n" +
          "\e[0;31;49mPlease don't enter numbers other than 0\e[0m\n"
        ).to_stdout
      end
      it 'in case of invalid input (same sign twice) - asks again' do
        allow(displayer).to receive(:gets).and_return("Justyna\n", "J\n", "Kota\n", "J\n", "K\n")
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
      it 'informs of mode, informs the user of computers names and signs' do
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
        allow(displayer).to receive(:gets).and_return("1")
        expect(displayer.get_order_information("Justyna", "Kota")).to eq("1")
      end
      it 'in case of invalid input - asks again - player1' do
        allow(displayer).to receive(:gets).and_return("3", "1")
        expect{displayer.get_order_information("Justyna", "Kota")}.to output(
          "If Justyna shall start enter 1, if Kota shall start enter 2\n" +
          "\e[0;31;49mPlease enter 1 or 2\e[0m\nJustyna is starting\n"
        ).to_stdout
      end
      it 'in case of invalid input - asks again - player2' do
        allow(displayer).to receive(:gets).and_return("3", "2")
        expect{displayer.get_order_information("Justyna", "Kota")}.to output(
          "If Justyna shall start enter 1, if Kota shall start enter 2\n" +
          "\e[0;31;49mPlease enter 1 or 2\e[0m\nKota is starting\n"
        ).to_stdout
      end
    end
  end

  context 'Setup is ready' do
    describe '#set_up_ready' do
      it 'tells the setup is ready, counts down from 5 to 1 and cleans the terminal window' do
        allow(displayer).to receive(:sleep)
        expect{displayer.set_up_ready}.to output(
          "\e[0;94;49m-------- Setup is ready! --------\e[0m\n" +
          "\e[0;94;49mYour game will start in\e[0m\n\e[0;94;49m5\e[0m\n" +
          "\e[0;94;49m4\e[0m\n\e[0;94;49m3\e[0m\n\e[0;94;49m2\e[0m\n\e[0;94;49m1\e[0m\n"
        ).to_stdout
      end
    end
  end

  context 'Game is in progress' do
    describe '#show_board' do
      it 'shows the current state of board' do
        expect{displayer.show_board(board.values, "J", "I")}.to output(
          "1 | 2 | 3 \n===+===+===\n4 | 5 | 6 \n===+===+===\n7 | 8 | 9 \n"
        ).to_stdout
      end
      it 'shows the board in colors' do
        expect{displayer.show_board(partialy_full_board.values, "J", "K")}.to output(
          "1 | \e[0;94;49mJ\e[0m | 3 \n===+===+===\n4 | 5 | 6 \n===+===+===\n7 | 8 | 9 \n"
        ).to_stdout
      end
    end
    describe '#ask_for_position' do
      it 'returns position picked by user on valid input' do
        allow(displayer).to receive(:gets).and_return("1")
        allow(board).to receive(:is_valid?).and_return(true)
        expect(displayer.ask_for_number(active_player, board)).to eq("1")
      end
      it 'in case of invalid input - asks again' do
        allow(displayer).to receive(:gets).and_return("1\n")
        allow(board).to receive(:is_valid?).and_return(false, true)
        expect{displayer.ask_for_number(active_player, board)}.to output(
          "justyna, pick a spot\n\e[0;31;49mPut a number of a non-taken field\e[0m\n"
        ).to_stdout
      end
    end
    describe '#color_cell' do
      it "doesn't color a cell when no match with a sign" do
        expect(displayer.color_cell("1", "J", "K")).to eq("1")
      end
      it "colors a cell in light_blue for first player" do
        expect(displayer.color_cell("J", "J", "K")).to eq("\e[0;94;49mJ\e[0m")
      end
      it "colors a cell in light_green for second player" do
        expect(displayer.color_cell("K", "J", "K")).to eq("\e[0;92;49mK\e[0m")
      end
    end
    describe '#inform_of_move' do
      it "informs of move" do
        expect{displayer.inform_of_move(active_player, "5")}.to output(
          "justyna picked 5\n"
        ).to_stdout
      end
    end
    describe '#clean_previous_board' do
      it "should receive system with clear" do
        allow(displayer).to receive(:system).with("clear")
      end
    end
  end


  context 'Game is over' do
    describe '#final_score_annoncement' do
      it 'announecs the winner if there is one' do
        allow(displayer).to receive(:system)
        allow(board).to receive(:is_game_won?).and_return true
        expect{displayer.final_score_annoncement(board, opponent)}.to output(
          "\e[0;33;49m---------------\nkota won\e[0m\n"
        ).to_stdout
      end
      it 'tells there was a tie' do
        allow(displayer).to receive(:system)
        allow(board).to receive(:is_game_won?).and_return false
        expect{displayer.final_score_annoncement(board, opponent)}.to output(
          "----------------\nIt's a tie\n"
        ).to_stdout
      end
    end
  end

end
