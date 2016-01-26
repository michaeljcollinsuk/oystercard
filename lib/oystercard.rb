class Oystercard
  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise "You may not exceed £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise 'Balance is too low' if @balance < MIN_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MIN_FARE)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
