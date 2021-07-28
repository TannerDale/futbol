require './lib/general_manager'

class StatTracker < GeneralManager

  def initialize(locations)
    super
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end
