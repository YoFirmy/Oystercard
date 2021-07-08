class Oystercard
  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys

  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = {}
  end

  def top_up(amount)
    fail "Balance is limited to £#{MAXIMUM_LIMIT}" if over_limit?(amount)
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @entry_station = station
  end
  
  def touch_out(station)
    @exit_station = station
    update_journeys
    deduct(MINIMUM_FARE)
  end

  private

  def update_journeys
    @journeys[@entry_station] = @exit_station
  end

  def over_limit?(amount)
    @balance + amount > MAXIMUM_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end
end
