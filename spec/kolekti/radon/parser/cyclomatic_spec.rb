require 'spec_helper'
require 'kolekti/radon/parser'

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
      [
        ['app.models.repository.Test:10.method:11',    1.0, :METHOD],
        ['app.models.repository.Test:10.method:14',    2.0, :METHOD],
        ['app.models.repository.Test:19.method',       1.0, :METHOD],
        ['app.models.repository.Test:19.other_method', 2.0, :METHOD],
        ['app.models.repository.test:1',               1.0, :FUNCTION],
        ['app.models.repository.test:4',               2.0, :FUNCTION]
      ].each do |module_name, complexity, granularity|
        expect(persistence_strategy).to receive(:create_tree_metric_result).with(
          cyclomatic_configuration,
          module_name,
          complexity,
          KalibroClient::Entities::Miscellaneous::Granularity.const_get(granularity)
        )
      end

      expect(logger).to receive(:debug).with(/error parsing file Rakefile/)

      subject.parse(raw_results)
    end
  end

  describe 'command' do
    it "'is expected to return 'cc'" do
      expect(subject.command).to eq('cc')
    end
  end

  describe 'self.default_value' do
    it 'is expected to return 1.0' do
      expect(described_class.default_value).to eq(1.0)
    end
  end
end
