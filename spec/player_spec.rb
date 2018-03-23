require 'player'

describe Player do

  subject(:player) { described_class.new("Justyna", "J") }

  context 'Initialization' do
    describe '#initialize' do
      it 'is initialized with a name' do
        expect(player.name).to eq("Justyna")
      end
      it 'is initialized with a sign' do
        expect(player.sign).to eq("J")
      end
    end
  end

end
