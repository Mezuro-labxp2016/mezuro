require 'rails_helper'

RSpec.describe KalibroConfiguration do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:metric_configurations).dependent(:destroy) }
  end

  describe 'hotspot_metric_configurations' do
    subject { FactoryGirl.build(:kalibro_configuration) }
    let(:tree_metric_configuration) { FactoryGirl.build(:tree_metric_configuration) }
    let(:hotspot_metric_configuration) { FactoryGirl.build(:hotspot_metric_configuration) }

    context 'when the kalibro configuration does not have hotspot metric configurations' do
      before :each do
        joins_metric_snapshot = mock('joins_metric_snapshot')
        MetricConfiguration.expects(:joins).with(:metric_snapshot).returns joins_metric_snapshot
        joins_metric_snapshot.expects(:where).with(metric_snapshots: { type: 'HotspotMetricSnapshot' },
                                                   kalibro_configuration_id: subject.id)
          .returns []
      end

      it 'is expected to return an empty array' do
        expect(subject.hotspot_metric_configurations).to eq([])
      end
    end

    context 'when the kalibro configuration has hotspot metric configurations' do
      before :each do
        joins_metric_snapshot = mock('joins_metric_snapshot')
        MetricConfiguration.expects(:joins).with(:metric_snapshot).returns joins_metric_snapshot
        joins_metric_snapshot.expects(:where).with(metric_snapshots: { type: 'HotspotMetricSnapshot' },
                                                   kalibro_configuration_id: subject.id)
          .returns [hotspot_metric_configuration]
      end

      it 'is expected to return a list of hotspot metric configurations' do
        expect(subject.hotspot_metric_configurations).to eq([hotspot_metric_configuration])
      end
    end
  end

  describe 'tree_metric_configurations' do
    subject { FactoryGirl.build(:kalibro_configuration) }
    let(:tree_metric_configuration) { FactoryGirl.build(:tree_metric_configuration) }
    let(:hotspot_metric_configuration) { FactoryGirl.build(:hotspot_metric_configuration) }

    context 'when the kalibro configuration does not have tree metric configurations' do
      before :each do
        joins_metric_snapshot = mock('joins_metric_snapshot')
        where_meric_snapshot = mock('where_meric_snapshot')
        tree_metric_configurations_mock = mock('tree_metric_configurations')
        MetricConfiguration.expects(:joins).with(:metric_snapshot).returns joins_metric_snapshot
        joins_metric_snapshot.expects(:where).returns(where_meric_snapshot)
        where_meric_snapshot.expects(:not).with(metric_snapshots: { type: 'HotspotMetricSnapshot' })
          .returns(tree_metric_configurations_mock)
        tree_metric_configurations_mock.expects(:where).with(kalibro_configuration_id: subject.id).returns []
      end

      it 'is expected to return an empty array' do
        expect(subject.tree_metric_configurations).to eq([])
      end
    end

    context 'when the kalibro configuration has tree metric configurations' do
      before :each do
        joins_metric_snapshot = mock('joins_metric_snapshot')
        where_meric_snapshot = mock('where_meric_snapshot')
        tree_metric_configurations_mock = mock('tree_metric_configurations')
        MetricConfiguration.expects(:joins).with(:metric_snapshot).returns joins_metric_snapshot
        joins_metric_snapshot.expects(:where).returns(where_meric_snapshot)
        where_meric_snapshot.expects(:not).with(metric_snapshots: { type: 'HotspotMetricSnapshot' })
          .returns(tree_metric_configurations_mock)
        tree_metric_configurations_mock.expects(:where).with(kalibro_configuration_id: subject.id)
          .returns [tree_metric_configuration]
      end

      it 'is expected to return a list of tree metric configurations' do
        expect(subject.tree_metric_configurations).to eq([tree_metric_configuration])
      end
    end
  end
end
