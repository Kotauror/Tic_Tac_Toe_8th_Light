require 'player'

describe Player do

  subject(:player) { described_class.new("Justyna") }

  context 'Initialization' do
    describe '#initialize' do
      it 'is initialized with a name' do
        expect(player.name).to eq("Justyna")
      end
      it 'has initial sign nil' do
        expect(player.sign).to eq(nil)
      end
    end
  end

  context 'Player setup' do
    describe '#set_up_sign' do
      it "sets the player's sign when a valid sign provided" do
        player.set_up_sign("J")
        expect(player.sign).to eq("J")
      end
      it "doesn't set the player's sign when an invalid sign provided" do
        player.set_up_sign("Justyna")
        expect(player.sign).to eq(nil)
      end
    end
  end

end
