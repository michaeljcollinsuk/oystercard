require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station}
  let(:exit_station) { double :station}
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
        oystercard.top_up(10)
        oystercard.touch_in(entry_station)
      end

      it 'deducts the penalty fare if the previous journey was not completed' do
        expect{oystercard.touch_in(entry_station)}.to change{oystercard.balance}.by (-Journey::PENALTY_FARE)
      end

      it 'saves the illegal journey to journey_history' do
        another_station = double(:station)
        oystercard.touch_in(another_station)
        expect(oystercard.journey_history).to include ({:start => entry_station})
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
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
    end

    describe '#touch_out' do

      it 'deducts the fare' do
        expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by (-Journey::MIN_FARE)
      end

      it 'records a journey' do
        oystercard.touch_out(exit_station)
        expect(oystercard.journey_history).to include ({:start => entry_station, :end => exit_station})
      end
    end
  end
end
