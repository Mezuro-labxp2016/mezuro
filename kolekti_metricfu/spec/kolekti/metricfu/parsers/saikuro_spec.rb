require 'spec_helper'

describe Kolekti::Metricfu::Parsers::Saikuro do
  it 'is expected to be a Base parser' do
    expect(subject).to be_a(Kolekti::Metricfu::Parsers::Base)
  end

  describe 'class methods' do
    describe 'parse' do
      let(:saikuro_results) { FactoryGirl.build(:metric_fu_results).results[:saikuro] }
      let(:metric_configuration) { FactoryGirl.build(:saikuro_metric_configuration) }
      let(:persistence_strategy) { FactoryGirl.build(:persistence_strategy) }

      it 'is expected to persist tree metric results' do
        expect(described_class).to receive(:parse_file_name).with(saikuro_results[:files][0][:filename]) { 'app.models.repository' }

        expect(described_class).to receive(:module_name_suffix).with('Repository#process') { '.Repository.process' }
        expect(described_class).to receive(:module_name_suffix).with('Repository#reprocess') { '.Repository.reprocess' }

        granularity = KalibroClient::Entities::Miscellaneous::Granularity::METHOD
        expect(persistence_strategy).to receive(:create_tree_metric_result).with(
          metric_configuration, 'app.models.repository.Repository.reprocess', 10.0, granularity
        )
        expect(persistence_strategy).to receive(:create_tree_metric_result).with(
          metric_configuration, 'app.models.repository.Repository.reprocess', 5.0, granularity
        ).never
        expect(persistence_strategy).to receive(:create_tree_metric_result).with(
          metric_configuration, 'app.models.repository.Repository.process', 10.0, granularity
        )

        described_class.parse(saikuro_results, metric_configuration, persistence_strategy)
      end
    end

    describe 'default_value' do
      it 'is expected to be one' do
        expect(described_class.default_value).to eq(1.0)
      end
    end
  end
end
