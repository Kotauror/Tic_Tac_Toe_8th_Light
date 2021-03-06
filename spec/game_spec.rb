require 'game'

describe Game do

  let(:displayer) {double('displayer')}
  subject(:game) { described_class.new(:displayer) }
  let(:human) {double('human')}
  let(:computer) {double('computer')}

  context 'Initialization' do
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
      it 'accepts displayer as an argument' do
        expect(game.displayer).not_to eq(nil)
      end
      it 'has rounds counter hat equals zero' do
        expect(game.displayer).not_to eq(0)
      end
    end
  end

  context 'Set up of the game' do
    describe '#set_up_mode(string)' do
      it 'sets the mode to the valid string' do
        game.set_up_mode("S")
        expect(game.mode).to eq("S")
      end

      it "doesn't set the mode to an invalid string" do
        game.set_up_mode("string")
        expect(game.mode).to eq(nil)
      end
    end

    describe '#set_player_1(object)' do
      it 'sets the player one to be an object' do
        game.set_player_1(:human)
        expect(game.player1).to eq(:human)
      end
    end

    describe '#set_player_2(object)' do
      it 'sets the player one to be an object' do
        game.set_player_2(:computer)
        expect(game.player2).to eq(:computer)
      end
    end

    describe '#set_active_player(object)' do
      it 'sets the active player' do
        game.set_active_player(:human)
        expect(game.active_player).to eq(:human)
      end
    end

    describe '#set_opponent(object)' do
      it 'sets the opposing player' do
        game.set_opponent(:computer)
        expect(game.opponent).to eq(:computer)
      end
    end
  end

  context 'game in progress' do
    describe '#switch_active_player' do
      it 'changes the active player' do
        game.set_active_player(:human)
        game.set_opponent(:computer)
        game.switch_active_player
        expect(game.active_player).to eq(:computer)
      end
    end
  end

end
