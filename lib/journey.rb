require_relative 'oystercard'

class Journey
  attr_reader :entry_station
  attr_reader :exit_station

  def initialize(station = nil)
    @entry_station = station
  end

  def complete_journey(station)
    @exit_station = station
  end

  def fare
    if @entry_station
      Oystercard::MINIMUM_FARE
    else
      Oystercard::PENALTY_CHARGE
    end
  end
end
