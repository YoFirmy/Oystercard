require 'journey'

describe Journey do
  describe '#initialization' do
    it "should store entry station when created" do
      station = double(:station)
      journey = Journey.new(station)
      expect(journey.entry_station).to eq(station)
    end
  end
  
  describe '#fare' do
    it "should give penalty fare if no entry station is given" do
      station = double(:station)
      subject.complete_journey(station)
      expect(subject.fare).to eq(Oystercard::PENALTY_CHARGE)
    end
  end
end
