require_relative 'station.rb'
require_relative 'journey.rb'
require_relative 'journey_log.rb'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE, journey_klass = JourneyLog)
    @balance = balance
    @journey_history = []
    @journeylog = journey_klass.new
  end

  def top_up(amount)
    raise "You may not exceed £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise 'Balance is too low' if @balance < MIN_BALANCE
    deduct(@journeylog.charge) if in_journey?
    @journeylog.start_journey(station)
  end

  def touch_out(station)
    @journeylog.end_journey(station)
    deduct(@journeylog.charge)
  end

  def history
    @journeylog.journeys
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @journeylog.journey
  end

end
