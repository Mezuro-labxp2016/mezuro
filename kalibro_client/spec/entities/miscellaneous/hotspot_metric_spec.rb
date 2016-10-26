require 'spec_helper'

describe KalibroClient::Entities::Miscellaneous::HotspotMetric, :type => :model do
  describe 'methods' do
    describe 'initialize' do
      context 'with valid attributes' do
        let(:name){ "Sample name"}
        let(:code){ "sample_code" }
        let(:languages){  [:RUBY] }
        let(:metric_collector_name){ "MetricFU" }
        let(:hotspot_metric){ KalibroClient::Entities::Miscellaneous::HotspotMetric.new(name, code, languages, metric_collector_name) }

        it 'is expected to return an instance of HotspotMetric' do
          expect(hotspot_metric).to be_a(KalibroClient::Entities::Miscellaneous::HotspotMetric)
        end

        it 'is expected to have SOFTWARE as the default scope' do
          expect(hotspot_metric.scope).to eq(KalibroClient::Entities::Miscellaneous::Granularity.new(:SOFTWARE))
        end

        it 'is expected to have HotspotMetricSnapshot type' do
          expect(hotspot_metric.type).to eq("HotspotMetricSnapshot")
        end
      end
    end

    describe 'to_object' do
      context 'with the expected attributes' do
        let(:hotspot_metric_hash) { FactoryGirl.attributes_for(:hotspot_metric) }
        it 'is expected to return a HotspotMetric' do
          expect(KalibroClient::Entities::Miscellaneous::HotspotMetric.to_object(hotspot_metric_hash)).to be_a(KalibroClient::Entities::Miscellaneous::HotspotMetric)
        end

        context 'and with some extra attributes' do
          let(:hotspot_metric_hash_extra) { hotspot_metric_hash.merge({"scope" => "SOFTWARE"}) }
          it 'is expected to return a HotspotMetric' do
            expect(KalibroClient::Entities::Miscellaneous::HotspotMetric.to_object(hotspot_metric_hash)).to be_a(KalibroClient::Entities::Miscellaneous::HotspotMetric)
          end
        end
      end

      context 'when the value is already an instance' do
        let(:hotspot_metric) { FactoryGirl.build(:hotspot_metric) }
        it 'is expected to return a HotspotMetric' do
          expect(KalibroClient::Entities::Miscellaneous::HotspotMetric.to_object(hotspot_metric)).to be_a(KalibroClient::Entities::Miscellaneous::HotspotMetric)
        end
      end
    end
  end
end
