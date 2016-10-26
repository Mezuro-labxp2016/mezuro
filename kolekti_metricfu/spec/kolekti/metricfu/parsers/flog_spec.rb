require 'spec_helper'

describe Kolekti::Metricfu::Parsers::Flog do
  it 'is expected to be a Base parser' do
    expect(subject).to be_a(Kolekti::Metricfu::Parsers::Base)
  end

  describe 'class methods' do
    describe 'parser' do
      let(:flog_results) { FactoryGirl.build(:metric_fu_results).results[:flog] }
      let(:metric_configuration) { FactoryGirl.build(:flog_metric_configuration) }
      let(:persistence_strategy) { FactoryGirl.build(:persistence_strategy) }

      it 'is expected to persist tree metric results' do
        expect(described_class).to receive(:parse_file_name).with(flog_results[:method_containers][0][:path]) { 'app.models.repository' }

        expect(described_class).to receive(:module_name_suffix).with('main#none') { '' }
        expect(described_class).to receive(:module_name_suffix).with('Repository#process') { '.Repository.process' }
        expect(described_class).to receive(:module_name_suffix).with('Repository#reprocess') { '.Repository.reprocess' }

        granularity = KalibroClient::Entities::Miscellaneous::Granularity::METHOD
        expect(persistence_strategy).to receive(:create_tree_metric_result).with(
          metric_configuration, 'app.models.repository.Repository.process', 1.1, granularity
        )
        expect(persistence_strategy).to receive(:create_tree_metric_result).with(
          metric_configuration, 'app.models.repository.Repository.reprocess', 2.0, granularity
        )

        described_class.parse(flog_results, metric_configuration, persistence_strategy)
      end
    end

    describe 'default_value' do
      it 'is expected to be zero' do
        expect(described_class.default_value).to eq(0.0)
      end
    end
  end
end
