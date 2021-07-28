require './lib/team_manager'
require './lib/game_manager'
require './lib/game_team_manager'

class GeneralManager
  attr_reader :game_manager, :team_manager, :game_teams_manager

  def initialize(files)
    @game_manager = GameManager.new(files[:games])
    @team_manager = TeamManager.new(files[:teams])
    @game_team_manager = GameTeamManager.new(files[:game_teams])
  end
end
