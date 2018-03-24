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
    describe '#is_valid?' do
      it 'checks if player can put the sign on intended position' do
        expect(board.is_valid?("1")).to eq(true)
      end
      it 'checks if player can put the sign on intended position' do
        board.put_sign_on_board(active_player, "3")
        expect(board.is_valid?("3")).to eq(false)
      end
    end
  end

end


def is_valid?(position)
  position.to_i != 0 && @values.include?(position)
end
