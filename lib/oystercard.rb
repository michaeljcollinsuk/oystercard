require_relative 'station.rb'
require_relative 'journey.rb'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey_history = []
  end

  def top_up(amount)
    raise "You may not exceed £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station, journey_klass = Journey)
    raise 'Balance is too low' if @balance < MIN_BALANCE
    deduct(@journey.fare) && @journey_history << @journey if in_journey?
    (@journey = journey_klass.new).start_journey(station)
  end

  def touch_out(station, journey_klass = Journey)
    (@journey ||= journey_klass.new).end_journey(station)
    deduct(@journey.fare)
    @journey_history << @journey
    @journey = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @journey
  end

end
