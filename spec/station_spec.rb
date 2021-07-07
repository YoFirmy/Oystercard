require 'station'

describe Station do
  describe '#zone' do
    let(:zone)  { 5 }
    it 'responds to zone' do
        expect(subject).to respond_to(:zone)
    end

    it 'defaults to DEFAULT_ZONE if no zone provided' do
      expect(subject.zone).to eq(Station::DEFAULT_ZONE)
    end

    it 'allows us to set zone' do
      subject.zone = zone
      expect(subject.zone).to eq(zone)
    end  
  end
end