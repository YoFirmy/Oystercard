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

    it "should return new journey created" do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      expect(subject.touch_in(station)).to be_instance_of(Journey)
    end

    it "should raise error if there are insufficient funds" do
      expect { subject.touch_in(station) }.to raise_error "Insufficient funds"
    end

    it 'gives penalty charge if tapped in twice' do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      subject.touch_in(station)
      expect{subject.touch_in(station)}.to change { subject.balance }.by (-Oystercard::PENALTY_CHARGE)
    end
  end

  describe '#touch_out' do
    let(:entry_station) { double :station }
    let(:exit_station) { double :station }

    before do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      # subject.touch_in(entry_station)
    end

    it { is_expected.to respond_to(:touch_out) }

    it "should deduct the fare from the balance" do
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end

    it "stores the exit station for journey" do
      expect { subject.touch_out(exit_station) }.to change { subject.journeys[0] }.from(nil).to be_a Journey
    end

    it "should set current journey back to nil" do
      subject.touch_out(exit_station)
      expect(subject.current_journey).to eq(nil)
    end

    it "should give a penalty if didnt previously touch in" do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::PENALTY_CHARGE)
    end
  end

  describe "#journeys" do
    it "has an empty list of journeys by default" do
      expect(subject.journeys).to be_empty
    end
  end
end
