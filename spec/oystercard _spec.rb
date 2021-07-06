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

  # describe '#deduct' do
  #   it { is_expected.to respond_to(:deduct).with(1).argument }

  #   it 'should deduct from the card' do
  #     subject.top_up(20)
  #     expect{ subject.deduct(10) }.to change{ subject.balance }.by -10
  #   end
  # end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }

    it "should confirm it is in use" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      expect(subject.touch_in).to eq(true)
    end

    it "should raise error if there are insufficient funds" do
      expect { subject.touch_in }.to raise_error "Insufficient funds"
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }

    it "should return true if touched in but not tapped out" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end

    it "should return false if touched out" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end

    it "should return false if it hasn't been used yet" do
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }

    it "should confirm it is no longer in use" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in
      expect(subject.touch_out).to eq(false)
    end

    it "should deduct the fare from the balance" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end
end
