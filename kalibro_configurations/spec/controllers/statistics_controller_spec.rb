require 'rails_helper'

RSpec.describe StatisticsController do
  describe '#metric_percentage' do
    let(:all_metrics) {
      [FactoryGirl.build(:metric_configuration), FactoryGirl.build(:metric_configuration),
       FactoryGirl.build(:metric_configuration)]
    }
    let(:metric_snapshot) { [FactoryGirl.build(:metric_snapshot)] }
    let(:no_metric_configuration) { [] }
    let(:no_metric_snapshot) { [] }

    context 'when metric has been used' do
      before :each do
        MetricConfiguration.expects(:all).returns(all_metrics)
        MetricSnapshot.expects(:where).returns(metric_snapshot)
        get :metric_percentage, metric_code: 'loc', format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'returns use percentage of the selected metric' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({ metric_percentage: 33.33 }.to_json))
      end
    end

    context 'when no metric configuration has been created' do
      before :each do
        MetricConfiguration.expects(:all).returns(no_metric_configuration)
        MetricSnapshot.expects(:where).returns(no_metric_snapshot)
        get :metric_percentage, metric_code: 'loc', format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'returns zero percentage' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({ metric_percentage: 0.0 }.to_json))
      end
    end

    context 'when metric was not used yet' do
      before :each do
        MetricConfiguration.expects(:all).returns(all_metrics)
        MetricSnapshot.expects(:where).returns(no_metric_snapshot)
        get :metric_percentage, metric_code: 'loc', format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'returns zero percentage' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({ metric_percentage: 0.0 }.to_json))
      end
    end
  end
end
