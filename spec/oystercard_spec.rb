require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station}
  let(:exit_station) { double :station}
  let(:journey) { double :journey }
  let(:journey_klass) { double :journey_klass, new: journey }
  subject(:oystercard) { described_class.new }

  it 'has a default balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  it 'keeps track of journey_history' do
    expect(oystercard.journey_history).to be_empty
  end

  describe '#top_up' do
    it 'tops up the oystercard by the amount passed in' do
      expect{oystercard.top_up(5)}.to change{oystercard.balance}.by 5
    end

    it 'raises an error if the user tries to exceed the maximum balance' do
      oystercard.top_up(Oystercard::MAX_BALANCE)
      expect{oystercard.top_up(1)}.to raise_error "You may not exceed £#{Oystercard::MAX_BALANCE}"
    end
  end

  describe '#touch_in' do
    context 'oystercard is topped up' do
      before do
        allow(journey).to receive(:start_journey).with(entry_station)
        allow(journey).to receive(:fare) { Journey::PENALTY_FARE }
        oystercard.top_up(10)
        oystercard.touch_in(entry_station, journey_klass)
      end

      it 'deducts the penalty fare if the previous journey was not completed' do
        allow(oystercard).to receive(:in_journey?) { true }
        expect{oystercard.touch_in(entry_station)}.to change{oystercard.balance}.by (-Journey::PENALTY_FARE)
      end

      it 'saves the illegal journey to journey_history' do
        another_station = double(:station)
        oystercard.touch_in(another_station)
        expect(oystercard.journey_history.size).to eq 1
      end

    end

    context 'when balance is under £1' do
      it 'raises an error' do
        expect{oystercard.touch_in(entry_station)}.to raise_error 'Balance is too low'
      end
    end
  end

  context 'oystercar is touched in' do

    before do
      allow(journey).to receive(:start_journey).with(entry_station)
      allow(journey).to receive(:end_journey).with(exit_station)
      allow(journey).to receive(:fare) { Journey::MIN_FARE }
      oystercard.top_up(10)
      oystercard.touch_in(entry_station, journey_klass)
    end

    describe '#touch_out' do

      it 'deducts the fare' do
        expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by (-Journey::MIN_FARE)
      end

      it 'records a journey' do
        oystercard.touch_out(exit_station)
        expect(oystercard.journey_history.size).to eq 1
      end
    end
  end
end
