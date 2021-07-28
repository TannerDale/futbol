require './lib/team_manager'
require './lib/game_manager'
require './lib/game_team_manager'

class GeneralManager
  attr_reader :game_manager, :team_manager, :game_teams_manager

  def initialize(locations)
    @game_manager = GameManager.new(locations[:games])
    @team_manager = TeamManager.new(locations[:teams])
    @game_team_manager = GameTeamManager.new(locations[:game_teams])
  end
end
