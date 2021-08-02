require_relative 'file_parser'
require_relative 'game'
require_relative 'game_teams'
require_relative 'team'

class Manager
  include FileParser

  def make_games(path)
    @@games = parse_games(path)
  end

  def make_game_teams(path)
    @@game_teams = parse_game_teams(path)
  end

  def process_game(data, game)
    data[:wins] += 1 if game.won?
    data[:total] += 1
  end
end
