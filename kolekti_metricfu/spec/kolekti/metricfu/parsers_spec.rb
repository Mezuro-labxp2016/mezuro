require 'spec_helper'

describe Kolekti::Metricfu::Parsers do
  describe 'methods' do
    describe 'parse_all' do
      let!(:flog_metric_configuration) { FactoryGirl.build(:flog_metric_configuration) }
      let!(:saikuro_metric_configuration) { FactoryGirl.build(:saikuro_metric_configuration) }
      let!(:flay_metric_configuration) { FactoryGirl.build(:flay_metric_configuration) }
      let(:wanted_metric_configurations) {
        {
        flog: flog_metric_configuration,
        saikuro: saikuro_metric_configuration,
        flay: flay_metric_configuration
      } }
      let(:metric_fu_results) { FactoryGirl.build(:metric_fu_results) }
      let(:persistence_strategy) { FactoryGirl.build(:persistence_strategy) }

      before :each do
        expect(YAML).to receive(:load_file) { metric_fu_results.results }
      end

      it 'is expected to call all parsers' do
        expect(Kolekti::Metricfu::Parsers::Flog).to receive(:parse)
        expect(Kolekti::Metricfu::Parsers::Saikuro).to receive(:parse)
        expect(Kolekti::Metricfu::Parsers::Flay).to receive(:parse)

        Kolekti::Metricfu::Parsers.parse_all('/test/test', wanted_metric_configurations, persistence_strategy)
      end
    end
  end
end
