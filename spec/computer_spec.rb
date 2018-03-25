require 'computer'

describe Computer do

  subject(:computer) { described_class.new("Computer 1", "C") }
  let(:board) {double('board', :values => ["1", "2", "3", "4", "5", "6", "7", "8", "9"])}

  context 'During the game' do
    describe 'select_number' do
      it 'selects the elaborate mode' do
        expect(computer).to receive(:elaborate_move).with board
        srand(5)
        computer.select_number(board)
      end
      it 'selects the random mode' do
        expect(computer).to receive(:random_move).with board
        srand(50)
        computer.select_number(board)
      end
    end
  end

end
