describe Kolekti::Radon::Parser::Raw do
  subject { described_class.new(double, double, double) }

  describe 'command' do
    it "'is expected to return 'raw'" do
        expect(subject.command).to eq('raw')
    end
  end

  describe 'self.default_value' do
    it 'is expected to return 0.0' do
      expect(described_class.default_value).to eq(0.0)
    end
  end
end
