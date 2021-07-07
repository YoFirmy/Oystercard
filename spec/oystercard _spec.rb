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

  describe '#touch_in' do
    let(:station) { double :station }
    it { is_expected.to respond_to(:touch_in) }

    it "should return station" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      expect(subject.touch_in(station)).to eq(station)
    end

    it "should raise error if there are insufficient funds" do
      expect { subject.touch_in(station) }.to raise_error "Insufficient funds"
    end

    it "should remember the entry station" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      expect { subject.touch_in(station) }.to change { subject.entry_station }.from(nil).to(station)
    end
  end

  describe '#in_journey?' do
    let(:station) { double :station }
    it { is_expected.to respond_to(:in_journey?) }

    it "should return true if touched in but not touched out" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it "should return false if touched out" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_out(station)
      expect(subject.in_journey?).to eq(false)
    end

    it "should return false if it hasn't been used yet" do
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe '#touch_out' do
    let(:station) { double :station }
    it { is_expected.to respond_to(:touch_out) }

    it "should deduct the fare from the balance" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end

    it "should remember the exit station" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      exit_station = double(:station)
      expect { subject.touch_out(exit_station) }.to change { subject.exit_station }.from(nil).to(exit_station)
    end
  end
  
  describe "#previous_trips" do
    it { is_expected.to respond_to(:previous_trips)}
  end

  describe "#journeys" do
    it "has an empty list of journeys by default" do
      expect(subject.journeys).to be_empty
    end

    

    it "stores an entry and exit station" do
      entry_station = double(:station)
      exit_station = double(:station)
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change {subject.journeys}.from({}).to({entry_station => exit_station})
    end
  end
end
