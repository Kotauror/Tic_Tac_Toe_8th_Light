require 'computer'

describe Computer do

  subject(:computer) { described_class.new("Computer 1", "C") }
  let(:board) {double('board', :values => ["1", "2", "3", "4", "5", "6", "7", "8", "9"])}
  let(:board_no_corners) {double('board', :values => ["2", "4", "5", "6", "8"])}
  let(:board_corner) {double('board', :values => ["1", "K", "3", "4", "J", "6", "7", "8", "9"])}
  let(:board_without_5) {double('board', :values => ["1", "2", "3", "J", "J", "6", "7", "8", "9"])}
  let(:board_winning_for_active) {double('board', :values => ["C", "C", "3", "K", "5", "6", "7", "8", "9"])}
  let(:board_winning_for_passive) {double('board', :values => ["C", "C", "3", "4", "J", "6", "7", "8", "9"])}
  let(:board_only_weak_positions) {double('board', :values => ["2", "4", "6", "8"])}

  before(:each) do
    allow(computer).to receive(:sleep)
  end

  context 'During the game' do
    describe 'pick_5_when_possible' do
      it 'picks 5 on board when 5 is available' do
        allow(board).to receive(:available_numbers).and_return(["1", "2", "3", "4", "5", "6", "7", "8", "9"])
        expect(computer.pick_5_when_possible(board)).to eq("5")
      end
      it 'doesn\'t pick 5 when 5 is not available' do
        allow(board_without_5).to receive(:available_numbers).and_return(["1", "2", "3", "4", "J", "6", "7", "8", "9"])
        expect(computer.pick_5_when_possible(board_without_5)).not_to eq("5")
      end
    end
    describe 'pick_winning_position' do
      it 'picks a winning position when possible' do
        allow(board_winning_for_active).to receive(:available_numbers).and_return(["3", "4", "5", "6", "7", "8", "9"])
        allow(board_winning_for_active).to receive(:put_sign_on_board).with("C", "3")
        allow(board_winning_for_active).to receive(:is_game_won?).and_return true
        allow(board_winning_for_active).to receive(:put_sign_on_board).with("3", "3")
        expect(computer.pick_winning_position(board_winning_for_active)).to eq("3")
      end
      it 'doesn\'t pick a winning position if not possible' do
        allow(board).to receive(:available_numbers).and_return(["1", "2", "3", "4", "5", "6", "7", "8", "9"])
        allow(board).to receive(:put_sign_on_board).with("C", "3")
        allow(board).to receive(:is_game_won?).and_return false
        allow(board).to receive(:put_sign_on_board).with("3", "3")
      end
    end
    describe 'block_opponent' do
      it 'blocks opponent when possible' do
        allow(board_winning_for_passive).to receive(:available_numbers).and_return(["3", "4", "5", "6", "7", "8", "9"])
        allow(board_winning_for_passive).to receive(:put_sign_on_board).with("K", "3")
        allow(board_winning_for_passive).to receive(:is_game_won?).and_return true
        allow(board_winning_for_passive).to receive(:put_sign_on_board).with("3", "3")
        expect(computer.block_opponent(board_winning_for_passive, "K")).to eq("3")
      end
      it 'doesn\'t block an opponent if not possible' do
        allow(board).to receive(:available_numbers).and_return(["1", "2", "3", "4", "5", "6", "7", "8", "9"])
        allow(board).to receive(:put_sign_on_board).with("K", "3")
        allow(board).to receive(:is_game_won?).and_return false
        allow(board).to receive(:put_sign_on_board).with("3", "3")
      end
    end
    describe 'pick_corner' do
      it 'picks a corner when possible' do
        allow(board_winning_for_active).to receive(:available_numbers).and_return(["3", "4", "5", "6", "7", "8", "9"])
        allow(board_winning_for_active).to receive(:include?).with("1").and_return(false)
        allow(board_winning_for_active).to receive(:include?).with("3").and_return(true)
        allow(board_winning_for_active).to receive(:put_sign_on_board).with("C", "3")
        expect(computer.pick_corner(board_winning_for_active)).to eq("3")
      end
      it 'doesn\'t pick a corner position if not possible' do
        allow(board_no_corners).to receive(:available_numbers).and_return(["2", "4", "6", "8"])
        expect(computer.pick_corner(board_no_corners)).to eq(nil)
      end
    end
    describe 'random_move' do
      it 'selects a random move' do
        srand(50)
        allow(board_only_weak_positions).to receive(:available_numbers).and_return(["2", "4", "6", "8",])
        expect(computer.random_move(board_only_weak_positions)).to eq("2")
      end
    end
    describe 'elaborate_move' do
      it 'returns 5 if pick_5_when_possible returned 5' do
        allow(board).to receive(:available_numbers).and_return ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        expect(computer.elaborate_move(board, "K")).to eq "5"
      end
      it 'returns winning position when 5 is not available and winning position is' do
        allow(board_winning_for_active).to receive(:available_numbers).and_return ["3", "6", "7", "8", "9", "7", "8", "9"]
        allow(board_winning_for_active).to receive(:put_sign_on_board).with("C", "3")
        allow(board_winning_for_active).to receive(:is_game_won?).and_return true
        allow(board_winning_for_active).to receive(:put_sign_on_board).with("3", "3")
        expect(computer.elaborate_move(board_winning_for_active, "K")).to eq "3"
      end
      it 'returns block-opponnet position when 5 and winning position are not available and block-opponent position is' do
        allow(board_winning_for_passive).to receive(:available_numbers).and_return ["3", "4", "6", "7", "8", "9", "7", "8", "9"]
        allow(board_winning_for_passive).to receive(:put_sign_on_board).with("C", "3")
        allow(board_winning_for_passive).to receive(:is_game_won?).and_return true
        allow(board_winning_for_passive).to receive(:put_sign_on_board).with("3", "3")
        expect(computer.elaborate_move(board_winning_for_passive, "K")).to eq "3"
      end
      it 'returns a corner position when 5, winning position and block-opponent are not available, but the corner is' do
        allow(board_corner).to receive(:available_numbers).and_return ["1", "3", "4", "6", "7", "8", "9"]
        allow(board_corner).to receive(:put_sign_on_board)
        allow(board_corner).to receive(:is_game_won?).and_return false
        expect(computer.elaborate_move(board_corner, "J")).to eq "1"
      end
      it 'returns random position when 5, winning position and block opponent position are not available' do
        allow(board_only_weak_positions).to receive(:available_numbers).and_return ["2", "4", "6", "8"]
        allow(board_only_weak_positions).to receive(:put_sign_on_board)
        allow(board_only_weak_positions).to receive(:is_game_won?).and_return false
        srand(50)
        expect(computer.elaborate_move(board_only_weak_positions, "K")).to eq "2"
      end
    end
  end
end
