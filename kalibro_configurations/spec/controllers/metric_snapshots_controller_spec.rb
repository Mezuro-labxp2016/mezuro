require 'rails_helper'

RSpec.describe MetricSnapshotsController do
  let(:metric_snapshot) { FactoryGirl.build(:metric_snapshot, id: 10) }

  describe 'index' do
    let!(:metric_snapshots) { [metric_snapshot] }

    before :each do
      MetricSnapshot.expects(:all).returns(metric_snapshots)

      get :index, format: :json
    end

    it { is_expected.to respond_with(:success) }

    it 'is expected to return the list of metric_snapshots converted to JSON' do
      expect(JSON.parse(response.body)).to eq(JSON.parse({metric_snapshots: metric_snapshots}.to_json))
    end
  end

  describe 'show' do
    context 'when the MetricSnapshot exists' do
      before :each do
        MetricSnapshot.expects(:find).with(metric_snapshot.id).returns(metric_snapshot)

        get :show, id: metric_snapshot.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return the list of metric_snapshots converted to JSON' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_snapshot: metric_snapshot}.to_json))
      end
    end

    context 'when the MetricSnapshot does not exist' do
      before :each do
        MetricSnapshot.expects(:find).with(metric_snapshot.id).raises(ActiveRecord::RecordNotFound)

        get :show, id: metric_snapshot.id, format: :json
      end

      it { is_expected.to respond_with(:not_found) }

      it 'should return the error description' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({errors: ['ActiveRecord::RecordNotFound']}.to_json))
      end
    end
  end

  describe 'metric_configuration' do
    let!(:metric_configuration) { FactoryGirl.build(:metric_configuration) }

    before :each do
      MetricSnapshot.expects(:find).with(metric_snapshot.id).returns(metric_snapshot)
      metric_snapshot.expects(:metric_configuration).returns(metric_configuration)

      get :metric_configuration, id: metric_snapshot.id, format: :json
    end

    it { is_expected.to respond_with(:success) }

    it 'is expected to return the list of metric_snapshots converted to JSON' do
      expect(JSON.parse(response.body)).to eq(JSON.parse({metric_configuration: metric_configuration}.to_json))
    end
  end
end
