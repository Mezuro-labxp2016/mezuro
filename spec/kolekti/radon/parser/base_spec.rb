describe Kolekti::Radon::Parser::Base do
  let(:persistence_strategy) { FactoryGirl.build(:persistence_strategy) }
  let(:loc_configuration) { FactoryGirl.build(:lines_of_code_metric_configuration) }
  let(:lloc_configuration) { FactoryGirl.build(:logical_lines_of_code_metric_configuration) }

  subject {
    described_class.new([loc_configuration, lloc_configuration], persistence_strategy, double)
  }

  describe 'parse' do
    let(:module_name) { 'app.models.repository' }
    let(:raw_results) { FactoryGirl.build(:radon_results).results[:raw] }

    it 'is expected to parse the results and create tree metric results' do
      granularity = KalibroClient::Entities::Miscellaneous::Granularity::PACKAGE
      expect(persistence_strategy).to receive(:create_tree_metric_result).with(
        loc_configuration, module_name, 14.0, granularity)
      expect(persistence_strategy).to receive(:create_tree_metric_result).with(
        lloc_configuration, module_name, 10.0, granularity)

      subject.parse(raw_results)
    end
  end

  describe 'command' do
    it 'is expected to raise a NotImplementedError' do
      expect { subject.command }.to raise_error(NotImplementedError)
    end
  end

  describe 'default_value' do
    it 'is expected to raise a NotImplementedError' do
      expect { subject.default_value }.to raise_error(NotImplementedError)
    end
  end
end
