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
    penalty? ? Oystercard::MINIMUM_FARE : Oystercard::PENALTY_CHARGE
  end

  private

  def penalty?
    @entry_station && @exit_station
  end
end
