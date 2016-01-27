class Journey

  attr_reader :journey_history, :current_journey

  def initialize
    @journey_history = []
    @current_journey = {}
  end

  def in_journey?
    @current_journey.has_key?(:entry_station)
  end

  def entry_station(station)
    @current_journey[:entry_station] = station
  end

  def exit_station(station)
    @current_journey[:exit_station] = station
    save_journey(@current_journey)
  end

  def save_journey(journey)
    @journey_history << @current_journey
    @current_journey = {}
  end

  def fare
    Oystercard::PENALTY_FARE if current_journey.has_key?(:exit_station) == false
    Oystercard::MIN_FARE
  end

end
