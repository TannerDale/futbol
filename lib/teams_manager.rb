require_relative 'manager'
require_relative 'file_parser'
require_relative 'team'


class TeamsManager < Manager
  include FileParser

  def initialize(file_path)
    @teams = parse_teams(file_path)
  end

  # Interface
  def team_info(team_id)
    team = @teams.find do |team|
      team.team_id == team_id
    end
    format_team_info(team)
  end

##helper
  def format_team_info(team)
    {
      "team_id" => team.team_id,
      "franchise_id" => team.franchise_id,
      "team_name" => team.team_name,
      "abbreviation" => team.abbreviation,
      "link" => team.link
    }
  end

  # Interface
  def count_of_teams
    @teams.count
  end

  def team_by_id(team_id)
    team = @teams.find do |team|
      team.team_id == team_id
    end
    team.team_name
  end
end
