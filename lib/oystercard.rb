class Oystercard

  attr_reader :balance

  MAX_BALANCE=90
  MIN_BALANCE=1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up (value)
    raise "Balance cannot exceed £#{MAX_BALANCE}" if (@balance + value) > MAX_BALANCE
    @balance += value
  end

  def deduct(value)
  	@balance -= value
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail 'Insufficient funds' if @balance < MIN_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
