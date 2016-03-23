require 'spec_helper'

describe Kolekti::CcPhpMd::Parser do
  before :each do
    expect(Kolekti::CcPhpMd::Collector).to receive(:create_cc_dir)
  end

  let(:collector) { Kolekti::CcPhpMd::Collector.new }
  let(:wanted_metrics) { collector.supported_metrics.first(2) }
  let(:wanted_metric_configurations) {
    Hash[
      wanted_metrics.map { |code, metric|
        [code, KalibroClient::Entities::Configurations::MetricConfiguration.new(metric: metric)]
      }
    ]
  }
  let(:persistence_strategy) { FactoryGirl.build(:persistence_strategy) }
  subject { described_class.new(collector, wanted_metric_configurations, persistence_strategy) }

  describe 'method' do
    describe 'write' do
      let(:data) { double }
      let(:wanted_metric_name) { wanted_metrics.first.second.name }

      context 'with invalid JSON data' do
        it 'is expected to raise a CollectorError' do
          expect(JSON).to receive(:parse).with(data).and_raise(JSON::ParserError.new)
          expect { subject.write(data) }.to raise_error(Kolekti::CollectorError, "Failed parsing CodeClimate JSON data")
        end
      end

      context 'with an unexpected type of data' do
        let(:jsdata) { {"type" => "whatever"} }

        it 'is expected to ignore the entry' do
          expect(JSON).to receive(:parse).with(data) { jsdata }
          expect(subject.write(data)).to be_truthy
          expect(persistence_strategy.hotspot_metric_results).to be_empty
        end
      end

      context 'with a check name not belonging to any metric configuration' do
        let(:jsdata) { {"type" => "issue", "check_name" => "whatever"} }

        it 'is expected to ignore the entry' do
          expect(JSON).to receive(:parse).with(data) { jsdata }
          expect(subject.write(data)).to be_truthy
          expect(persistence_strategy.hotspot_metric_results).to be_empty
        end
      end

      context 'with an invalid location' do
        let(:jsdata) { {"type" => "issue", "check_name" => wanted_metric_name} }

        it 'is expected to raise a CollectorError' do
          expect(JSON).to receive(:parse).with(data) { jsdata }
          expect { subject.write(data) }.to raise_error(Kolekti::CollectorError, "Unexpected CodeClimate JSON data")
        end
      end

      context 'with valid data' do
        let(:metric_configuration) { wanted_metric_configurations.values.first }
        let(:jsdata) {
          { "type" => "issue",
            "check_name" => metric_configuration.metric.name,
            "description" => "description",
            "location" => {
              "path" => "path/asd.php",
              "lines" => {"begin" => 1, "end" => 2}
            }
         }
       }

        it 'is expected to generate a result' do
          expect(JSON).to receive(:parse).with(data) { jsdata }
          expect(subject.write(data)).to be_truthy
          expect(persistence_strategy.hotspot_metric_results).to include({
            :line => 1,
            :message => "description",
            :module_name => "path.asd",
            :metric_configuration => metric_configuration
          })
        end
      end
    end

    describe 'failed' do
      it 'is expected to raise a CollectorError' do
        expect { subject.failed('error') }.to raise_error(Kolekti::CollectorError)
      end
    end
  end
end
