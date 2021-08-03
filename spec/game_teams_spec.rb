require 'spec_helper'

RSpec.describe GameTeams do
  it 'does something' do
    game_teams = GameTeams.new(game_teams_data = {})

    expect(game_teams).to be_a GameTeams
    expect(game_teams.won?).to be_boolean
  end
end
