require 'journey_log'

describe JourneyLog do
  let(:journey) { double :journey }
  let(:station) { double :station }
  let(:journey_klass) { double :journey_klass, new: journey}
  subject(:journeylog) { described_class.new(journey_klass) }

  describe 'initialize' do
    it 'initializes with an empty journey array' do
      expect(journeylog.journeys).to eq []
    end
  end

  describe '#start_journey' do
    it 'starts a journey' do
      allow(journey).to receive(:fare)
      expect(journey).to receive(:start_journey).with(station)
      journeylog.start_journey(station)
    end

    it 'records the illegal journey' do
      allow(journey).to receive(:fare)
      allow(journey).to receive(:start_journey)
      another_station = double(:station)
      journeylog.start_journey(station)
      journeylog.start_journey(another_station)
      expect(journeylog.journeys.size).to eq 1
    end
  end

  describe '#end_journey' do
    it 'ends a journey' do
      allow(journey).to receive(:fare)
      expect(journey).to receive(:end_journey).with(station)
      journeylog.end_journey(station)
    end

    it 'records a journey' do
      allow(journey).to receive(:fare)
      allow(journey).to receive(:start_journey)
      allow(journey).to receive(:end_journey)
      journeylog.start_journey(station)
      journeylog.end_journey(station)
      expect(journeylog.journeys.size).to eq 1
    end
  end

  describe '#journeys' do
    it 'returns a duplicate of the journeys array' do
      allow(journey).to receive(:fare)
      allow(journey).to receive(:start_journey)
      allow(journey).to receive(:end_journey)
      journeylog.start_journey(station)
      journeylog.end_journey(station)
      expect(journeylog.journeys).to include journey
    end
  end

  describe '#outstanding_charges' do
    it 'returns the fare' do
      allow(journey).to receive(:fare)
      allow(journey).to receive(:start_journey)
      journeylog.start_journey(station)
      expect(journey).to receive(:fare)
      journeylog.outstanding_charges
    end
  end


end
