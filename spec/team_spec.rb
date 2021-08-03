require 'spec_helper'

RSpec.describe Team do
  it 'exists' do
    team = Team.new(team_data = {})

    expect(team).to be_a Team
  end
end
