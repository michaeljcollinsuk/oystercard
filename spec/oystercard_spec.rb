require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  it 'has a default balance of 0' do
    expect(oystercard.balance).to eq 0
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

  describe '#deduct' do
    it 'deducts the specified amount' do
      oystercard.top_up(1)
      expect{oystercard.deduct(1)}.to change{oystercard.balance}.by -1
    end
  end

  describe '#in_journey?' do
    it 'defaults to false' do
      expect(oystercard).to_not be_in_journey
    end
  end

  describe '#touch_in' do
    it 'sets the oyster card to be in journey' do
      oystercard.top_up(1)
      expect{oystercard.touch_in}.to change{oystercard.in_journey?}.to true
    end

    context 'when balance is under £1' do
      it 'raises an error' do
        expect{oystercard.touch_in}.to raise_error 'Balance is too low'
      end
    end
  end

  describe '#touch_out' do
    it 'sets the oyster card to no longer be in journey' do
      oystercard.top_up(1)
      oystercard.touch_in
      expect{oystercard.touch_out}.to change{oystercard.in_journey?}.to false
    end
  end

end
