class Journey
  attr_reader :entry_station
  attr_reader :exit_station

  def initialize(station)
    @entry_station = station
  end

  def complete_journey(station)
    @exit_station = station
  end
end
