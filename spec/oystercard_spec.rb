require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  it 'initializes with a default balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  describe '#top_up' do
    it 'tops up the oystercard by the amount passed in' do
      expect{oystercard.top_up(5)}.to change{oystercard.balance}.by 5
    end
  end

end
