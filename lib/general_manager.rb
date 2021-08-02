require_relative 'teams_manager'
require_relative 'games_manager'
require_relative 'game_teams_manager'
require_relative 'seasons_manager'

class GeneralManager
  attr_reader :teams_manager, :games_manager, :game_teams_manager

  def initialize(locations)
    @seasons_manager = SeasonsManager.new
    @teams_manager = TeamsManager.new(locations[:teams])
    @games_manager = GamesManager.new(locations[:games])
    @game_teams_manager = GameTeamsManager.new(locations[:game_teams])
  end

  def team_info(team_id)
    @teams_manager.team_info(team_id)
  end

  def count_of_teams
    @teams_manager.count_of_teams
  end

  def highest_total_score
    @games_manager.score_results(:max)
  end

  def lowest_total_score
    @games_manager.score_results(:min)
  end

  def count_of_games_by_season
    @seasons_manager.count_of_games_by_season
  end

  def average_goals_by_season
    @seasons_manager.average_goals_by_season
  end

  def average_goals_per_game
    @games_manager.average_goals_per_game
  end

  def highest_scoring_home_team
    id = @games_manager.team_scores(:home, :max)
    @teams_manager.team_by_id(id)
  end

  def lowest_scoring_home_team
    id = @games_manager.team_scores(:home, :min)
    @teams_manager.team_by_id(id)
  end

  def highest_scoring_visitor
    id = @games_manager.team_scores(:away, :max)
    @teams_manager.team_by_id(id)
  end

  def lowest_scoring_visitor
    id = @games_manager.team_scores(:away, :min)
    @teams_manager.team_by_id(id)
  end

  def favorite_opponent(team_id)
    id = @games_manager.opponent_results(team_id, :fav)
    @teams_manager.team_by_id(id)
  end

  def rival(team_id)
    id = @games_manager.opponent_results(team_id, :rival)
    @teams_manager.team_by_id(id)
  end

  def winningest_coach(season)
    @seasons_manager.coach_results(season, :max)
  end

  def worst_coach(season)
    @seasons_manager.coach_results(season, :min)
  end

  def most_accurate_team(season)
    id = @seasons_manager.accuracy_results(season, :max)
    @teams_manager.team_by_id(id)
  end

  def least_accurate_team(season)
    id = @seasons_manager.accuracy_results(season, :min)
    @teams_manager.team_by_id(id)
  end

  def most_tackles(season)
    id = @seasons_manager.tackle_results(season, :max)
    @teams_manager.team_by_id(id)
  end

  def fewest_tackles(season)
    id = @seasons_manager.tackle_results(season, :min)
    @teams_manager.team_by_id(id)
  end

  def best_season(team_id)
    @seasons_manager.season_results(team_id, :max)
  end

  def worst_season(team_id)
    @seasons_manager.season_results(team_id, :min)
  end

  def average_win_percentage(team_id)
    @game_teams_manager.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @game_teams_manager.goal_results(team_id, :max)
  end

  def fewest_goals_scored(team_id)
    @game_teams_manager.goal_results(team_id, :min)
  end

  def best_offense
    id = @game_teams_manager.offense_results(:max)
    @teams_manager.team_by_id(id)
  end

  def worst_offense
    id = @game_teams_manager.offense_results(:min)
    @teams_manager.team_by_id(id)
  end

  def percentage_home_wins
    @game_teams_manager.percentage_hoa_wins(:home)
  end

  def percentage_visitor_wins
    @game_teams_manager.percentage_hoa_wins(:away)
  end

  def percentage_ties
    @game_teams_manager.percentage_ties
  end
end
