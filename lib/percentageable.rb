module Percentageable
  def hash_avg(data)
    count, total = data.keys
    data[count].fdiv(data[total])
  end

  def avg(num1, num2)
    num1.fdiv(num2)
  end

  def get_accuracy_avg(accuracy_data)
    accuracy_data.reduce({}) do |acc, data|
      acc[data.first] = hash_avg(data.last)
      acc
    end
  end

  def season_avgs(win_data)
    win_data.map do |season, stats|
      [season, hash_avg(stats)]
    end
  end

  def get_offense_avgs(goal_data)
     goal_data.map do |team, data|
      [team, hash_avg(data).round(2)]
    end.to_h
  end

  def get_percentage_ties(games)
    tie_stats = games.reduce({ties: 0, total: 0}) do |acc, game|
      acc[:total] += 1
      if game.result == "TIE"
        acc[:ties] += 1
      end
      acc
    end
    hash_avg(tie_stats).round(2)
  end

  def get_percentage_hoa_wins(team, games)
    stats = games.reduce({wins: 0, total: 0}) do |acc, game|
      acc[:total] += 0.5
      if game.won? && game.home_away == team
        acc[:wins] += 1
      end
      acc
    end
    hash_avg(stats).round(2)
  end

  def win_percent(win_loss)
    win_loss.map do |team, results|
      [team, hash_avg(results)]
    end
  end

  def avg_season_goals(goal_data)
    goal_data.reduce({}) do |acc, goals|
      acc[goals[0]] = avg(goals[1], get_games_per_season(goals[0])).round(2)
      acc
    end
  end

  def goal_per_game_avg(games)
    goals = games.sum do |game|
      game.total_goals
    end
    (avg(goals, games.size)).round(2)
  end
end
