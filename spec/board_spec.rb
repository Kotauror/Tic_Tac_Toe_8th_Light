require 'board'

describe Board do

  subject(:board) { described_class.new }


  context 'Initialization' do
    describe '#initialize' do
      it 'has an array of values from 1 to 9' do
        expect(board.board_values).to eq(["1", "2", "3", "4", "5", "6", "7", "8", "9"])
      end
    end
  end

end
