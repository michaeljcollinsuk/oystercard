require_relative 'journey'

class JourneyLog


  def initialize(journeyKlass = Journey)
    @journey_klass = journeyKlass
    @journeys = []
  end

  def start_journey(station)
    @journeys << @journey if @journey
    @journey = @journey_klass.new
    @journey.start_journey(station)
  end

  def end_journey(station)
    (@journey ||= @journey_klass.new).end_journey(station)
    @journeys << @journey
    @journey = nil
  end

  def journeys
    @journeys.dup
  end

  def fare
    @journey.fare
  end

  private

  def current_journey
    @journey ||= @journey_klass.new
  end
end
