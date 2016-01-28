require 'journey.rb'

describe Journey do

  subject(:journey) { described_class.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  describe '#start_journey' do
    it 'stores the entry station in the current_journey hash' do
      journey.start_journey(entry_station)
      expect(journey.entry_station).to eq entry_station
    end
  end

  describe '#end_journey' do
    it 'stores the exit station in the current_journey hash' do
      journey.end_journey(exit_station)
      expect(journey.exit_station).to eq exit_station
    end
  end

  context 'journey has started' do

    before do
      journey.start_journey(entry_station)
    end

    describe '#journey_complete?' do
      it 'returns false when the journey is incomplete' do
        expect(journey.journey_complete?).to eq false
      end

      it 'returns true when the journey is complete' do
        journey.end_journey(exit_station)
        expect(journey.journey_complete?).to eq true
      end
    end

    describe '#fare' do
      it 'should charge penalty fare if the journey is not complete' do
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end

      it 'should charge the minimum fare for a legal journey' do
        journey.end_journey(exit_station)
        expect(journey.fare).to eq Journey::MIN_FARE
      end
    end
  end
end
