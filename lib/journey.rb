
class Journey
  MIN_FARE = 1
  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def journey_complete?
    @entry_station && @exit_station ? true : false
  end

  def fare
    journey_complete? ? MIN_FARE : PENALTY_FARE
  end

end
