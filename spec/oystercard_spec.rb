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

      it 'raises an error if user tries to top-up balance over 90' do
        oyster.top_up(Oystercard::MAX_BALANCE)
        expect{oyster.top_up(1)}.to raise_error "Balance cannot exceed £#{Oystercard::MAX_BALANCE}"
      end
   	end


   describe '#deduct' do
   		it 'should deduct amount off balance passed through method' do
   			expect{oyster.deduct(1)}.to change{ oyster.balance}.by -1
   		end

   	end


end
