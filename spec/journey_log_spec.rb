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
      expect(journey).to receive(:start_journey).with(station)
      journeylog.start_journey(station)
    end
  end


end
