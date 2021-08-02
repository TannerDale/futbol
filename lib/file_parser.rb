require "csv"

module FileParser
  def parse_games(file_path)
    games = []
    CSV.foreach(file_path, headers: true) do |row|
      games << Game.new(row)
    end
    games
  end

  def parse_game_teams(file_path)
    game_teams = []
    CSV.foreach(file_path, headers: true) do |row|
      game_teams << GameTeams.new(row)
    end
    game_teams
  end

  def parse_teams(file_path)
    teams = []
    CSV.foreach(file_path, headers: true) do |row|
      teams << Team.new(row)
    end
    teams
  end
end
