require 'oystercard.rb'

describe Oystercard do
  subject(:oyster) { described_class.new }

  it 'has a default balance of 0' do
    expect(oyster.balance).to eq 0
  end

 describe '#top-up' do
		it 'can top up by amount passed in' do
			expect{ oyster.top_up(1)}.to change{ oyster.balance}.by 1
		end

context 'oyster card is topped up' do
  before do
    oyster.top_up(Oystercard::MAX_BALANCE)
  end

  it 'raises an error if user tries to top-up balance over 90' do
      expect{oyster.top_up(1)}.to raise_error "Balance cannot exceed £#{Oystercard::MAX_BALANCE}"
    end
  end

  describe '#deduct' do
		it 'should deduct amount off balance passed through method' do
			expect{oyster.deduct(1)}.to change{oyster.balance}.by -1
		end
	end
end

  describe '#in_journey?' do
    it 'initially is not in journey' do
      expect(oyster).to_not be_in_journey
    end
  end

  context 'oyster is touched in' do

    before do
      oyster.top_up(Oystercard::MIN_BALANCE)
      oyster.touch_in
    end

    describe '#touch_in' do
      it 'changes in_journey? to true' do
        expect(oyster).to be_in_journey
      end
    end

    describe '#touch_out' do
      it 'changes in_journey? to false' do
          oyster.touch_out
          expect(oyster).to_not be_in_journey
      end
    end
  end

  context 'zero balance on oyster' do
    it 'does not touch in if balance is below £1' do
      expect{oyster.touch_in}.to raise_error 'Insufficient funds'
    end
  end
end
