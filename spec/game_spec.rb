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
  end

end
