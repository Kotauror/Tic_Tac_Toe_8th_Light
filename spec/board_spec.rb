require 'board'

describe Board do

  subject(:board) { described_class.new }
  let(:active_player) {double('active player', :sign => "J")}


  context 'Initialization' do
    describe '#initialize' do
      it 'has an array of values from 1 to 9' do
        expect(board.values).to eq(["1", "2", "3", "4", "5", "6", "7", "8", "9"])
      end
    end
  end

  context 'Game in progress' do
    describe '#put_sign_on_board' do
      it 'puts a sign picked by the user on the board' do
        board.put_sign_on_board(active_player, "3")
        expect(board.values).to eq(["1", "2", "J", "4", "5", "6", "7", "8", "9"])
      end
    end
  end

end
