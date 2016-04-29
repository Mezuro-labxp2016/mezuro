describe Kolekti::Radon::Parser::Cyclomatic do
  let(:logger) { instance_double(Logger) }
  let(:persistence_strategy) { FactoryGirl.build(:persistence_strategy) }
  let(:cyclomatic_configuration) { FactoryGirl.build(:cyclomatic_metric_configuration) }

  subject {
    described_class.new([cyclomatic_configuration], persistence_strategy, logger)
  }

  describe 'parse' do
    let(:module_name) { 'app.models.repository' }
    let(:raw_results) { FactoryGirl.build(:radon_results).results[:cc] }

    it 'is expected to parse the results and create tree metric results' do
      expect(persistence_strategy).to receive(:create_tree_metric_result).with(
        cyclomatic_configuration, "app.models.repository.Client.method1", 1.0,
        KalibroClient::Entities::Miscellaneous::Granularity::METHOD)
      expect(persistence_strategy).to receive(:create_tree_metric_result).with(
        cyclomatic_configuration, "app.models.repository.Client.method2", 5.0,
        KalibroClient::Entities::Miscellaneous::Granularity::METHOD)
      expect(persistence_strategy).to receive(:create_tree_metric_result).with(
        cyclomatic_configuration, "app.models.repository.callFunction", 3.0,
        KalibroClient::Entities::Miscellaneous::Granularity::FUNCTION)

      expect(logger).to receive(:debug).with(/error parsing file Rakefile/)

      subject.parse(raw_results)
    end
  end

  describe 'command' do
    it "'is expected to return 'cc'" do
      expect(subject.command).to eq('cc')
    end
  end

  describe 'default_value' do
    it 'is expected to return 1.0' do
      expect(subject.default_value).to eq(1.0)
    end
  end
end
