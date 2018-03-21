require 'game'

describe Game do

  subject(:game) { described_class.new }

  it 'has initial mode of nil' do
    expect(game.mode).to eq(nil)
  end

end
