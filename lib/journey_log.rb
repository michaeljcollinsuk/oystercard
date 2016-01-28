require_relative 'journey'

class JourneyLog

  attr_reader :journeys, :journey

  def initialize(journeyKlass = Journey)
    @journey_klass = journeyKlass
    @journeys = []
  end

  def start_journey(station)
    @journey = @journey_klass.new
    @journey.start_journey(station)
  end

  # private

  def current_journey
    @journey ||= @journey_klass.new
  end
end
