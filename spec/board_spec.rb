require 'board'

describe Board do

  subject(:board) { described_class.new }
  let(:active_player) {double('active player', :sign => "J")}
  let(:opponent) {double('opponent', :sign => "O")}


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
    describe '#is_game_won?' do
      it 'tells that the game is won when 1-2-3' do
        board.put_sign_on_board(active_player, "1")
        board.put_sign_on_board(active_player, "2")
        board.put_sign_on_board(active_player, "3")
        expect(board.is_game_won?).to eq(true)
      end
      it 'tells that the game is won when 4-5-6' do
        board.put_sign_on_board(active_player, "4")
        board.put_sign_on_board(active_player, "5")
        board.put_sign_on_board(active_player, "6")
        expect(board.is_game_won?).to eq(true)
      end
      it 'tells that the game is won when 7-8-9' do
        board.put_sign_on_board(active_player, "7")
        board.put_sign_on_board(active_player, "8")
        board.put_sign_on_board(active_player, "9")
        expect(board.is_game_won?).to eq(true)
      end
      it 'tells that the game is won when 1-4-7' do
        board.put_sign_on_board(active_player, "1")
        board.put_sign_on_board(active_player, "4")
        board.put_sign_on_board(active_player, "7")
        expect(board.is_game_won?).to eq(true)
      end
      it 'tells that the game is won when 2-5-8' do
        board.put_sign_on_board(active_player, "2")
        board.put_sign_on_board(active_player, "5")
        board.put_sign_on_board(active_player, "8")
        expect(board.is_game_won?).to eq(true)
      end
      it 'tells that the game is won when 3-6-9' do
        board.put_sign_on_board(active_player, "3")
        board.put_sign_on_board(active_player, "6")
        board.put_sign_on_board(active_player, "9")
        expect(board.is_game_won?).to eq(true)
      end
      it 'tells that the game is won when 1-5-9' do
        board.put_sign_on_board(active_player, "1")
        board.put_sign_on_board(active_player, "5")
        board.put_sign_on_board(active_player, "9")
        expect(board.is_game_won?).to eq(true)
      end
      it 'tells that the game is won when 3-5-7' do
        board.put_sign_on_board(active_player, "3")
        board.put_sign_on_board(active_player, "5")
        board.put_sign_on_board(active_player, "7")
        expect(board.is_game_won?).to eq(true)
      end
      it 'tells that the game is not won - other cases' do
        board.put_sign_on_board(active_player, "1")
        board.put_sign_on_board(active_player, "5")
        board.put_sign_on_board(active_player, "7")
        expect(board.is_game_won?).to eq(false)
      end
    end
  end
  describe '#is_tie?' do
    it 'returns true when there is a tie' do
      board.put_sign_on_board(active_player, "1")
      board.put_sign_on_board(opponent, "2")
      board.put_sign_on_board(active_player, "3")
      board.put_sign_on_board(opponent, "4")
      board.put_sign_on_board(active_player, "6")
      board.put_sign_on_board(opponent, "5")
      board.put_sign_on_board(active_player, "7")
      board.put_sign_on_board(opponent, "9")
      board.put_sign_on_board(active_player, "8")
      expect(board.is_tie?).to eq true
    end
    it 'returns false when there is no tie' do
      board.put_sign_on_board(active_player, "1")
      board.put_sign_on_board(opponent, "2")
      board.put_sign_on_board(active_player, "3")
      board.put_sign_on_board(opponent, "4")
      board.put_sign_on_board(active_player, "6")
      board.put_sign_on_board(opponent, "5")
      board.put_sign_on_board(active_player, "7")
      board.put_sign_on_board(opponent, "9")
      expect(board.is_tie?).to eq false
    end
  end

end
