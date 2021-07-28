require 'csv'
require './lib/team'

class TeamManager
  attr_reader :teams

  def initialize(file_path)
    @teams = []
    add_teams(file_path)
  end

  # Helper
  def add_teams(team_data)
    CSV.foreach(file_path, headers: true) do |row|
      @teams << Team.new(row)
    end
  end

  # Interface
  def team_info(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end
  end

  # Interface
  def count_of_teams
    @teams.count
  end


  #####

  # Interface
  def favorite_opponent(team_id)
    win_loss = calculate_win_percents(team_id)
    fav_team = win_loss.max_by do |team, result|
      result
    end.first

    team_info(fav_team)["team_name"]
  end

  # Interface
  def rival(team_id)
    win_loss = calculate_win_percents(team_id)
    rival_team = win_loss.min_by do |team, result|
      result
    end.first

    team_info(rival_team).team_name
  end

  # Helper
  def calculate_win_percents(team_id)
    win_loss = opponent_win_count(team_id)
    win_loss.map do |team, results|
      avg = results[:wins].fdiv(results[:total])
      [team, avg]
    end.to_h
  end

  # GameManager Method
  # We send team_id, they return hash with opp_id & results against
  def opponent_win_count(team_id)
    win_loss = {}
    @games.each do |game|
      if game[:home_team_id] == team_id || game[:away_team_id] == team_id
        data = get_home_or_away(team_id, game)

        win_loss[data[:opp_id]] ||= {wins: 0, total: 0}
        if data[:team_goals] > data[:opp_goals]
          win_loss[data[:opp_id]][:wins] += 1
        end
        win_loss[data[:opp_id]][:total] += 1
      end
    end
    win_loss
  end

  # GameManager Method
  # Full send
  def get_home_or_away(team_id, game)
    teams = [game[:home_team_id], game[:away_team_id]]
    goals = [game[:home_goals], game[:away_goals]]
    team_index = teams.index(team_id)
    opp_index = team_index - 1
    {
      team_goals: goals[team_index],
      opp_id: teams[opp_index],
      opp_goals: goals[opp_index]
    }
  end


  ####

  # Interface
  def average_win_percentage(team_id)
    wins = 0
    games = 0
    seasons_win_count(team_id, @games).each do |season, stats|
      wins += stats[:wins]
      games += stats[:total]
    end
    (wins.fdiv(games)).round(2)
  end

  # Interface
  def best_offense
    team_id = get_offense_averages.max_by do |team, data|
      data
    end.first

    team_info(team_id)["team_name"]
  end

  # Interface
  def worst_offense
    team_id = get_offense_averages.min_by do |team, data|
      data
    end.first

    team_info(team_id)["team_name"]
  end

  # Helper
  def get_offense_averages
     get_goals_per_team.map do |team, data|
      [team, data[:goals].fdiv(data[:total])]
    end.to_h
  end

  # GameManager
  # Full send
  def get_goals_per_team
    team_goals = {}
    @games.each do |game|
      team_goals[game[:home_team_id]] ||= {goals: 0, total: 0}
      team_goals[game[:away_team_id]] ||= {goals: 0, total: 0}

      team_goals[game[:home_team_id]][:goals] += game[:home_goals].to_i
      team_goals[game[:home_team_id]][:total] += 1

      team_goals[game[:away_team_id]][:goals] += game[:away_goals].to_i
      team_goals[game[:away_team_id]][:total] += 1
    end
    team_goals
  end
end
