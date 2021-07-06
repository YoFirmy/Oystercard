class Oystercard
  attr_reader :balance
  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Balance is limited to £#{MAXIMUM_LIMIT}" if over_limit?(amount)
    @balance += amount
  end

  def in_journey?
    !!@in_journey
  end

  def touch_in
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @in_journey = true
  end
  
  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

  private

  def over_limit?(amount)
    @balance + amount > MAXIMUM_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end
end
