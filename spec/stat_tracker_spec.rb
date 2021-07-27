require 'spec_helper'

RSpec.describe StatTracker do
  it "exists" do
    game_path = './data/mini_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/mini_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker).to be_a(StatTracker)
  end

  it "has attributes" do
    game_path = './data/mini_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/mini_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    it 'has team info' do
      expect(stat_tracker.teams).not_to be_empty
    end

    it ;has
    expect(stat_tracker.game_teams).not_to be_empty
    expect(stat_tracker.games).not_to be_empty
    expect(stat_tracker.team_info("18")).to eq(expected)
    expect(stat_tracker.best_season("15")).to eq("20162017")
    expect(stat_tracker.worst_season("15")).to eq("20142015")
    expect(stat_tracker.average_win_percentage("15")).to eq(0.63)
  end
end
