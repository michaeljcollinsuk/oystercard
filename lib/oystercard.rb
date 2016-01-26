class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
    @journey = {}
  end

  def top_up(amount)
    raise "You may not exceed £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @journey.has_key?(:entry_station)
  end

  def touch_in(station)
    raise 'Balance is too low' if @balance < MIN_BALANCE
    @journey[:entry_station] = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journey[:exit_station] = station
    @journeys << @journey
    @journey = {}
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
