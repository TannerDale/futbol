require 'csv'

class GameManager
  include CSVParser

  def initialize(file_path)
    @games = []
    make_games(file_path)
  end

  def make_games(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      @games << Game.new(row)
    end
  end
end
