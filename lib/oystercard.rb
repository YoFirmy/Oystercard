class Oystercard
  attr_reader :balance
  MAXIMUM_LIMIT = 90
  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Balance is limited to £#{MAXIMUM_LIMIT}" if over_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
  
  private

  def over_limit?(amount)
    @balance + amount > MAXIMUM_LIMIT
  end
end
