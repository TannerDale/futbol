require 'spec_helper'

RSpec.describe Game do
  it 'exists' do
    game = Game.new(game_data = {})

    expect(game).to be_a Game
  end
end
