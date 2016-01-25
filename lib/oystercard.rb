class Oystercard

  attr_reader :balance

  MAX_BALANCE=90

  def initialize
    @balance = 0
  end

  def top_up (value)
    raise "Balance cannot exceed £#{MAX_BALANCE}" if (@balance + value) > MAX_BALANCE
    @balance += value
  end

  def deduct(value)
  	@balance -= value
  end






end

