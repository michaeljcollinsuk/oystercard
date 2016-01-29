
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
    journey_complete? ? MIN_FARE + calculate_zone : PENALTY_FARE
  end

  def calculate_zone
    (entry_station.zone - exit_station.zone).abs * MIN_FARE
  end

end
