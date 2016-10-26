require 'spec_helper'

describe Kolekti::Metricfu::Parsers::Flay do
  it 'is expected to be a Base parser' do
    expect(subject).to be_a(Kolekti::Metricfu::Parsers::Base)
  end

  describe 'class methods' do
    describe 'parse' do
      let(:flay_results) { FactoryGirl.build(:metric_fu_results).results[:flay] }
      let(:metric_configuration) { FactoryGirl.build(:flay_metric_configuration) }
      let(:persistence_strategy) { instance_double(Kolekti::MemoryPersistenceStrategy) }
      let(:first_results) {
        [
          {'module_name' => 'lib.metric_collector.native.metric_fu.parser.flay',
           'line' => 38,
           'message' => '1) Similar code found in :module (mass = 154)'},
          {'module_name' => 'lib.metric_collector.native.metric_fu.parser.flog',
           'line' => 38,
           'message' => '1) Similar code found in :module (mass = 154)'}
        ]
      }
      let(:second_results) {
        [
          {'module_name' => 'app.controllers.processings_controller',
           'line' => 63,
           'message' => '6) IDENTICAL code found in :defn (mass*2 = 64)'},
          {'module_name' => 'app.controllers.repositories_controller',
           'line' => 63,
           'message' => '6) IDENTICAL code found in :defn (mass*2 = 64)'},
          {'module_name' => 'lib.metric_collector.native.metric_fu.parser.saikuro',
           'line' => 63,
           'message' => '6) IDENTICAL code found in :defn (mass*2 = 64)'}
        ]
      }

      it 'is expected to persist hotspot metrics and its related results' do
        expect(described_class).to receive(:parse_file_name).with('lib/metric_collector/native/metric_fu/parser/flay.rb') { 'lib.metric_collector.native.metric_fu.parser.flay' }
        expect(described_class).to receive(:parse_file_name).with('lib/metric_collector/native/metric_fu/parser/flog.rb') { 'lib.metric_collector.native.metric_fu.parser.flog' }
        expect(described_class).to receive(:parse_file_name).with('app/controllers/processings_controller.rb') { 'app.controllers.processings_controller' }
        expect(described_class).to receive(:parse_file_name).with('app/controllers/repositories_controller.rb') { 'app.controllers.repositories_controller' }
        expect(described_class).to receive(:parse_file_name).with('lib/metric_collector/native/metric_fu/parser/saikuro.rb') { 'lib.metric_collector.native.metric_fu.parser.saikuro' }

        expect(persistence_strategy).to receive(:create_related_hotspot_metric_results).with(metric_configuration, first_results)
        expect(persistence_strategy).to receive(:create_related_hotspot_metric_results).with(metric_configuration, second_results)

        described_class.parse(flay_results, metric_configuration, persistence_strategy)
      end
    end
  end
end
