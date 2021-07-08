require 'journey'

describe Journey do
  describe '#initialization' do
    it "should store entry station when created" do
      station = double(:station)
      journey = Journey.new(station)
      expect(journey.entry_station).to eq(station)
    end
  end
end
