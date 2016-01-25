require 'oystercard.rb'

describe Oystercard do
  subject(:oyster) { described_class.new }

  it 'has a default balance of 0' do
    expect(oyster.balance).to eq 0
  end

   describe '#top-up' do
   		it 'can top up by amount passed in' do
   			expect{ subject.top_up(1)}.to change{ subject.balance}.by 1   			
   		end
   		
   	end






end
