require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(balance = DEFAULT_BALANCE, journey = Journey.new)
    @balance = balance
    @journey = journey
  end

  def top_up(amount)
    raise "You may not exceed £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise 'Balance is too low' if @balance < MIN_BALANCE
    @journey.entry_station(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journey.exit_station(station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
