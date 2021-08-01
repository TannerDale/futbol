require 'csv'
require_relative 'game_teams'
require_relative 'seasons_manager'

class GameTeamsManager < SeasonsManager
  attr_reader :game_teams

  def initialize(file_path)
    @game_teams = []
    make_game_teams(file_path)
  end

  def make_game_teams(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      @game_teams << GameTeams.new(row)
    end
  end

  def coach_results(season, min_max)
    results = {
      max: -> { coach_win_pct(season).max_by { |coach, pct| pct }.first },
      min: -> { coach_win_pct(season).min_by { |coach, pct| pct }.first }
    }
    results[min_max].call
  end

  def accuracy_results(season, min_max)
    average = get_accuracy_avg(accuracy_data(season))
    results = {
      max: -> { average.max_by { |team, avg| avg }.first },
      min: -> { average.min_by { |team, avg| avg }.first }
    }
    results[min_max].call
  end

  def tackle_results(season, min_max)
    results = {
      max: -> { team_tackles(season).max_by { |team, tackles| tackles }.first },
      min: -> { team_tackles(season).min_by { |team, tackles| tackles }.first }
    }
    results[min_max].call
  end

  def season_results(id, min_max)
    averages = season_avgs(seasons_win_count(id))
    results = {
      max: -> { averages.max_by { |season, avg| avg }.first },
      min: -> { averages.min_by { |season, avg| avg }.first }
    }
    results[min_max].call
  end

  def average_win_percentage(id)
    team_stats = team_win_stats(id)
    hash_avg(team_stats).round(2)
  end

  def team_win_stats(id)
    @game_teams.reduce({wins: 0, total: 0}) do |acc, game|
      process_game(acc, game) if game.team_id == id
      acc
    end
  end

  def process_game(data, game)
    data[:wins] += 1 if game.won?
    data[:total] += 1
  end

  def goal_results(id, min_max)
    results = {
      min: -> { goals_per_team_game(id).min },
      max: -> { goals_per_team_game(id).max }
    }
    results[min_max].call
  end

  def goals_per_team_game(id)
    @game_teams.map do |game|
      game.goals if game.team_id == id
    end.compact
  end

  def offense_results(min_max)
    shot_data = get_offense_avgs(get_goals_per_team)
    results = {
      min: -> { shot_data.min_by { |team, data| data }.first },
      max: -> { shot_data.max_by { |team, data| data }.first }
    }
    results[min_max].call
  end

  def get_goals_per_team
    @game_teams.reduce({}) do |acc, game|
      acc[game.team_id] ||= {goals: 0, total: 0}
      acc[game.team_id][:goals] += game.goals
      acc[game.team_id][:total] += 1
      acc
    end
  end

  def percentage_hoa_wins(hoa)
    team = {home: "home", away: "away"}
    get_percentage_hoa_wins(team[hoa], @game_teams)
  end

  def percentage_ties
    get_percentage_ties(@game_teams)
  end
end
