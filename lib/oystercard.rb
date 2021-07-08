class Oystercard
  attr_reader :balance
  attr_reader :journeys
  attr_reader :current_journey

  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1
  PENALTY_CHARGE = 6

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    fail "Balance is limited to £#{MAXIMUM_LIMIT}" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if insufficient_funds?
    deduct(@current_journey.fare) if @current_journey
    @current_journey = Journey.new(station)
  end
  
  def touch_out(station)
    finish_current_journey(station)
    deduct(@current_journey.fare)
    update_journeys
  end

  private

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def finish_current_journey(station)
    @current_journey ? @current_journey.complete_journey(station) : @current_journey = Journey.new
  end

  def update_journeys
    @journeys << @current_journey
    @current_journey = nil
  end

  def over_limit?(amount)
    @balance + amount > MAXIMUM_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end
end
