require 'rails_helper'

RSpec.describe MetricSnapshot do
  describe 'associations' do
    it { is_expected.to have_one(:metric_configuration) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:scope) }
  end

  describe 'as_json' do
    context 'with a native metric snapshot' do
      subject { FactoryGirl.build(:native_metric_snapshot) }

      it 'should not include a script value' do
        expect(subject.as_json).to_not include('script')
      end

      it 'should include metric_collector_name' do
        expect(subject.as_json).to include('metric_collector_name')
        expect(subject.metric_collector_name).to eq(subject.as_json['metric_collector_name'])
      end

      it 'is expected to set the type to native_metric' do
        expect(subject.as_json['type']).to eq('NativeMetricSnapshot')
      end
    end

    context 'with a hotspot metric snapshot' do
      subject { FactoryGirl.build(:hotspot_metric_snapshot) }

      it 'should not include a script value' do
        expect(subject.as_json).to_not include('script')
      end

      it 'should include metric_collector_name' do
        expect(subject.as_json).to include('metric_collector_name')
        expect(subject.metric_collector_name).to eq(subject.as_json['metric_collector_name'])
      end

      it 'is expected to set the type to hotspot_metric' do
        expect(subject.as_json['type']).to eq('HotspotMetricSnapshot')
      end

      it 'is expected to have SOFTWARE scope' do
        expect(subject.as_json['scope']).to eq('SOFTWARE')
      end
    end

    context 'with a compound metric snapshot' do
      subject { FactoryGirl.build(:compound_metric_snapshot) }

      it 'should not include a metric_collector_name' do
        expect(subject.as_json).to_not include('metric_collector_name')
      end

      it 'should include script' do
        expect(subject.as_json).to include('script')
        expect(subject.script).to eq(subject.as_json['script'])
      end

      it 'is expected to set the type to compound_metric' do
        expect(subject.as_json['type']).to eq('CompoundMetricSnapshot')
      end
    end
  end
end
