require 'oystercard'

describe Oystercard do
  describe '#initialize' do
    it 'gives a new card a balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should top up the card' do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by 10
    end

    it 'raises an error if balance exceeds maximum limit' do
      maximum_limit = Oystercard::MAXIMUM_LIMIT
      subject.top_up(maximum_limit)
      expect { subject.top_up(1) }.to raise_error "Balance is limited to £#{maximum_limit}"
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'should deduct from the card' do
      subject.top_up(20)
      expect{ subject.deduct(10) }.to change{ subject.balance }.by -10
    end
  end
end
