require 'spec_helper'

describe Kolekti::MemoryPersistenceStrategy do
  let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
  let(:module_name) { 'module_name' }

  subject { described_class.new }

  describe 'create_tree_metric_result' do
    let(:value) { 12 }
    let(:granularity) { KalibroClient::Entities::Miscellaneous::Granularity::METHOD }
    let(:result_hash) {
      {
        metric_configuration: metric_configuration,
        module_name: module_name,
        value: value,
        granularity: granularity
      }
    }

    it 'is expected to store the result in memory' do
      subject.create_tree_metric_result(metric_configuration, module_name, value, granularity)

      expect(subject.tree_metric_results).to eq([result_hash])
    end
  end

  describe 'create_hotspot_metric_result' do
    let(:line) { 10 }
    let(:message) { 'message '}
    let(:result_hash) {
      {
        metric_configuration: metric_configuration,
        module_name: module_name,
        line: line,
        message: message
      }
    }
    it 'is expected to store the result in memory' do
      subject.create_hotspot_metric_result(metric_configuration, module_name, line, message)

      expect(subject.hotspot_metric_results).to eq([result_hash])
    end
  end

  describe 'create_related_hotspot_metric_results' do
    let(:results) {[
      {'module_name' => 'moduleA', 'line' => 10, 'message' => 'some message'},
      {'module_name' => 'moduleB', 'line' => 20, 'message' => 'other message'}
    ]}

    let(:results_hashes) { results.map { |res| res.merge(metric_configuration: metric_configuration) } }

    before :each do
      results.zip(results_hashes).each do |result, result_hash|
        subject.expects(:create_hotspot_metric_result).with(metric_configuration, result['module_name'],
                                                            result['line'], result['message']).returns(result_hash)
      end
    end

    it 'is expected to store the result in memory' do
      subject.create_related_hotspot_metric_results(metric_configuration, results)

      expect(subject.related_hotspot_metric_results).to eq([results_hashes])
    end
  end
end
