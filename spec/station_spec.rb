require 'station'

describe Station do
  let(:name) { 'East Croydon' }
  describe '#initialization' do
    it "takes a name as an argument" do
      station = Station.new(name)
      expect(station.name).to eq(name)
    end
  end

  describe '#zone' do
    let(:zone)  { 5 }
    it 'responds to zone' do
        expect(Station.new(name)).to respond_to(:zone)
    end

    it 'defaults to DEFAULT_ZONE if no zone provided' do
      expect(Station.new(name).zone).to eq(Station::DEFAULT_ZONE)
    end

    it 'allows us to set zone' do
      station = Station.new(name)
      station.zone = zone
      expect(station.zone).to eq(zone)
    end  
  end
end