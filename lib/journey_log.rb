require_relative 'journey'

class JourneyLog

  attr_reader :journey, :charge

  def initialize(journeyKlass = Journey)
    @journey_klass = journeyKlass
    @journeys = []
  end

  def start_journey(station)
    @journeys << @journey if @journey
    @journey = @journey_klass.new
    @journey.start_journey(station)
    outstanding_charges
  end

  def end_journey(station)
    (@journey ||= @journey_klass.new).end_journey(station)
    @journeys << @journey
    outstanding_charges
    @journey = nil
  end

  def journeys
    @journeys.dup
  end

  def outstanding_charges
    @charge = @journey.fare
  end

  private

  def current_journey
    @journey ||= @journey_klass.new
  end
end
