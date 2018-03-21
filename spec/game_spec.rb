require 'game'

describe Game do

  subject(:game) { described_class.new }

  describe '#initialize' do
    it 'has initial mode nil' do
      expect(game.mode).to eq(nil)
    end
    it 'has empty player1 slot' do
      expect(game.player1).to eq(nil)
    end
    it 'has empty player2 slot' do
      expect(game.player2).to eq(nil)
    end
    it 'has empty active player slot' do
      expect(game.active_player).to eq(nil)
    end
    it 'has empty opponent slot' do
      expect(game.opponent).to eq(nil)
    end
    it 'creates a new board instance of the Board class' do
      expect(game.board).to be_a_kind_of(Board)
    end
  end

  describe '#set_up_mode(string)' do
    it 'sets the mode to the string' do
      game.set_up_mode("single")
      expect(game.mode).to eq("single")
    end
  end

end
