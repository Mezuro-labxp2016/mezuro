require 'spec_helper'

describe Kolekti::PersistenceStrategy do
  describe 'methods' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
    subject { described_class.new }

    describe 'create_tree_metric_result' do
      it 'is expected to raise a NotImplementedError' do
        expect {
          subject.create_tree_metric_result(metric_configuration, 'module_name', 12,
                                            KalibroClient::Entities::Miscellaneous::Granularity::METHOD)
        }.to raise_error NotImplementedError
      end
    end

    describe 'create_hotspot_metric_result' do
      it 'is expected to raise a NotImplementedError' do
        expect {
          subject.create_hotspot_metric_result(metric_configuration, 'module_name', 10, 'mess')
        }.to raise_error NotImplementedError
      end
    end

    describe 'create_related_hotspot_metric_results' do
      let(:results) {[
        {:module_name => 'moduleA', :line => 10, :message => 'some message'},
        {:module_name => 'moduleB', :line => 20, :message => 'other message'}
      ]}

      it 'is expected to raise a NotImplementedError' do
        expect {
          subject.create_related_hotspot_metric_results(metric_configuration, results)
        }.to raise_error NotImplementedError
      end
    end
  end
end
