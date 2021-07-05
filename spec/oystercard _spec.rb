require 'oystercard'

describe Oystercard do
  describe '#initialize' do
    it 'gives a new card a balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'allows user to add money to card' do
      expect(subject.top_up(10)).to eq(10)
    end

    it 'saves balance to be topped up multiple times' do
      subject.top_up(10)
      expect(subject.top_up(10)).to eq(20)
    end

    it 'raises an error if balance is more than £90' do
      maximum_limit = Oystercard::MAXIMUM_LIMIT
      subject.top_up(maximum_limit)
      expect { subject.top_up(1) }.to raise_error "Balance is limited to £#{maximum_limit}"
    end
  end
end
