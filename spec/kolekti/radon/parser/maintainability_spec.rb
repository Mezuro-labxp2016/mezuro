describe Kolekti::Radon::Parser::Maintainability do
  subject { described_class.new(double, double, double) }

  describe 'command' do
    it "'is expected to return 'mi'" do
      expect(subject.command).to eq('mi')
    end
  end

  describe 'self.default_value' do
    it 'is expected to return 0.0' do
      expect(described_class.default_value).to eq(100.0)
    end
  end
end
