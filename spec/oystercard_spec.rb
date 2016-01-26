require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station}
  let(:exit_station) { double :station}

  subject(:oystercard) { described_class.new }
  it 'has a default balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  it 'keeps track of journeys' do
    expect(oystercard.journeys).to be_empty
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

  describe '#in_journey?' do
    it 'defaults to false' do
      expect(oystercard).to_not be_in_journey
    end
  end

  describe '#touch_in' do
    context 'oystercard is topped up' do
      before do
        oystercard.top_up(1)
      end

      it 'sets the oyster card to be in journey' do
        expect{oystercard.touch_in(entry_station)}.to change{oystercard.in_journey?}.to true
      end

      it 'records the station where oystercard is touched in' do
        oystercard.touch_in(entry_station)
        expect(oystercard.entry_station).to eq entry_station
      end
    end

    context 'when balance is under £1' do
      it 'raises an error' do
        expect{oystercard.touch_in(entry_station)}.to raise_error 'Balance is too low'
      end
    end
  end

  describe '#touch_out' do
    before do
      oystercard.top_up(1)
      oystercard.touch_in(entry_station)
    end

    it 'sets the oyster card to no longer be in journey' do
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.in_journey?}.to false
    end

    it 'deducts the minimum amount' do
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by (-Oystercard::MIN_FARE)
    end

    it 'sets entry station to nil' do
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.entry_station}.to nil
    end

    it 'records the station where the oyster card is touched out' do
      oystercard.touch_out(exit_station)
      expect(oystercard.exit_station).to eq exit_station
    end

    let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

    it 'records a journey' do
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys).to include journey
    end
  end

end
