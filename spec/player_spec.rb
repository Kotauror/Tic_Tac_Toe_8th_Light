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
  
end
