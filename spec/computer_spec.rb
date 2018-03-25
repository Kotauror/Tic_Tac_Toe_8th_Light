require 'computer'

describe Computer do

  subject(:computer) { described_class.new("Computer 1", "C") }
  let(:board) {double('board', :values => ["1", "2", "3", "4", "5", "6", "7", "8", "9"])}
  let(:board_without_4) {double('board', :values => ["1", "2", "3", "J", "5", "6", "7", "8", "9"])}
  let(:board_winning_for_active) {double('board', :values => ["C", "C", "3", "K", "5", "6", "7", "8", "9"])}
  let(:board_winning_for_passive) {double('board', :values => ["K", "K", "3", "J", "5", "6", "7", "8", "9"])}

  context 'During the game' do
    describe 'select_number' do
      it 'selects the elaborate mode' do
        expect(computer).to receive(:elaborate_move).with(board, "K")
        srand(5)
        computer.select_number(board, "K")
      end
      it 'selects the random mode' do
        expect(computer).to receive(:random_move).with board
        srand(50)
        computer.select_number(board, "K")
      end
    end
  end
  describe 'pick_4_when_possible' do
    it 'picks 4 when available' do
      expect(computer.pick_4_when_possible(board)).to eq(4)
    end
    it 'doesn\'t pick 4 when not available' do
      expect(computer.pick_4_when_possible(board_without_4)).not_to eq(4)
    end
  end
  describe 'pick_winning_position' do
    it 'picks a winning position when possible' do
      allow(board_winning_for_active).to receive(:available_numbers).and_return(["3", "4", "5", "6", "7", "8", "9"])
      allow(board_winning_for_active).to receive(:put_sign_on_board).with("C", "3")
      allow(board_winning_for_active).to receive(:is_game_won?).and_return true
      allow(board_winning_for_active).to receive(:put_sign_on_board).with("3", "3")
      expect(computer.pick_winning_position(board_winning_for_active)).to eq(3)
    end
  end
  describe 'block_opponent' do
    it 'blocks opponent when possible' do
      allow(board_winning_for_passive).to receive(:available_numbers).and_return(["3", "4", "5", "6", "7", "8", "9"])
      allow(board_winning_for_passive).to receive(:put_sign_on_board).with("K", "3")
      allow(board_winning_for_passive).to receive(:is_game_won?).and_return true
      allow(board_winning_for_passive).to receive(:put_sign_on_board).with("3", "3")
      expect(computer.block_opponent(board_winning_for_passive, "K")).to eq(3)
    end
  end


end
