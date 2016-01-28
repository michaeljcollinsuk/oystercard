require_relative 'oystercard.rb'

class Journey
  MIN_FARE = 1
  PENALTY_FARE = 6
  attr_reader :current_journey
  def initialize
    @current_journey = {}
  end

  def start_journey(entry_station)
    @current_journey[:start] = entry_station
  end

  def end_journey(exit_station)
    @current_journey[:end] = exit_station
  end

  def journey_complete?
    current_journey.has_key?(:start) && current_journey.has_key?(:end)
  end

  def fare
    journey_complete? ? MIN_FARE : PENALTY_FARE
  end

end
