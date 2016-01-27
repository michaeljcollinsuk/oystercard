class Journey

  attr_reader :journey_history, :current_journey, :faree

  def initialize
    @journey_history = []
    @current_journey = {}
  end

  def in_journey?
    @current_journey.has_key?(:entry_station)
  end

  def entry_station(station)
    # save_journey(@current_journey) if in_journey?
    if in_journey?
      @journey_history << @current_journey
      @faree = Oystercard::PENALTY_FARE
    end
    @current_journey[:entry_station] = station
  end

  def exit_station(station)
    if in_journey? == false
      @current_journey[:exit_station] = station
      @journey_history << @current_journey
      @current_journey = {}
      @faree = PENALTY_FARE
    else
      @current_journey[:exit_station] = station
      @journey_history << @current_journey
      # journey_complete(@current_journey)
      @faree = fare(@current_journey)
      @current_journey = {}
    end
  end

  # def save_journey(journey)
  #   @journey_history << @current_journey
  #   @current_journey = {}
  # end

  def journey_complete?(current_journey)
    current_journey.has_key?(:entry_station) && current_journey.has_key?(:exit_station)
  end

  def fare(journey_to_be_charged)
    Oystercard::PENALTY_FARE if journey_complete?(journey_to_be_charged) == false
    Oystercard::MIN_FARE if journey_complete?(journey_to_be_charged)
  end

end
