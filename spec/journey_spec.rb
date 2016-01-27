require 'journey'
require 'oystercard'


describe Journey do
  subject(:journey) { described_class.new }
  let(:oystercard) { double :oystercard }

  it 'creates a blank journey history by default' do
    expect(journey.journey_history).to be_empty
  end

  describe '#in_journey?' do
    it 'defaults to false' do
      expect(journey).to_not be_in_journey
    end
  end

  describe '#entry_station' do
    it 'changes in journey to true' do
      journey.entry_station(:Bank)
      expect(journey.in_journey?).to be true
    end
  end

  describe '#exit_station' do
    it 'sets current_journey to no longer be in journey' do
      journey.entry_station(:Bank)
      expect{journey.exit_station(:Aldgate)}.to change{journey.in_journey?}.to false
    end
  end

  describe '#save_journey' do
    it 'saves the journey in the journey history' do
      journey.entry_station(:Bank)
      journey.exit_station(:Aldgate)
      expect(journey.journey_history).to include({:entry_station=>:Bank, :exit_station=>:Aldgate})
    end
  end

  # describe '#fare' do
  #   it 'charges the minimum fare' do
  #     journey.entry_station(:Bank)
  #     journey.exit_station(:Aldgate)
  #     expect(journey.fare).to eq Oystercard::MIN_FARE
  #   end
  #
  #   it 'charges the penalty fare' do
  #     journey.entry_station(:Bank)
  #     expect(journey.fare).to eq Oystercard::PENALTY_FARE
  #   end
  # end

end
