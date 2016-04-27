require 'spec_helper'

describe Kolekti::Radon::Collector do
  describe 'class method' do
    describe 'available?' do
      let(:command_params){ ['radon', '--version', [:out, :err] => '/dev/null'] }

      context 'with a successful call (system exit 0)' do
        it 'is expected to call the system executable and return true' do
          expect(described_class).to receive(:system).with(*command_params) { true }

          expect(described_class.available?).to be_truthy
        end
      end

      context 'with a failed call to system executable (it is not installed)' do
        it 'is expected to call the system executable and return false' do
          expect(described_class).to receive(:system).with(*command_params) { nil }

          expect(described_class.available?).to be_falsey
        end
      end

      context 'with a errored call to system executable (it is installed but not working: non-zero exit)' do
        it 'is expected to call the system executable and return false' do
          expect(described_class).to receive(:system).with(*command_params) { false }

          expect(described_class.available?).to be_falsey
        end
      end
    end
  end

  describe 'instance method' do
    describe 'initialize' do
      let(:supported_metrics) { double }

      it 'is expected to load the supported metrics' do
        expect_any_instance_of(described_class).to receive(:parse_supported_metrics).with(
          /\/metrics\.yml$/, 'Radon', [:PYTHON]) { supported_metrics }

        subject = described_class.new
        expect(subject.supported_metrics).to eq(supported_metrics)
      end
    end

    describe 'collect_metrics' do
      def metric_configuration_double
        instance_double(KalibroClient::Entities::Configurations::MetricConfiguration)
      end

      let(:code_directory) { "/tmp/test" }
      let(:persistence_strategy) { double }

      context 'with known metrics' do
        let(:cc_parser) { instance_double(Kolekti::Radon::Parser::Cyclomatic) }
        let(:mi_parser) { instance_double(Kolekti::Radon::Parser::Maintainability) }
        let(:raw_parser) { instance_double(Kolekti::Radon::Parser::Raw) }
        let(:cc_metric_configuration) { metric_configuration_double }
        let(:mi_metric_configuration) { metric_configuration_double }
        let(:raw_metric_configurations) {
          {"loc" => metric_configuration_double, "sloc" => metric_configuration_double}
        }
        let(:wanted_metric_configurations) {
          {"cc" => cc_metric_configuration, "mi" => mi_metric_configuration}.merge(raw_metric_configurations)
        }

        it 'is expected to collect and parse all metrics' do
          expect(Kolekti::Radon::Parser::Cyclomatic).to receive(:new).
            with([cc_metric_configuration], persistence_strategy).and_return(cc_parser)
          expect(Kolekti::Radon::Parser::Maintainability).to receive(:new).
            with([mi_metric_configuration], persistence_strategy).and_return(mi_parser)
          expect(Kolekti::Radon::Parser::Raw).to receive(:new).
            with(raw_metric_configurations.values, persistence_strategy).and_return(raw_parser)

          expect(subject).to receive(:run_radon).with(code_directory, cc_parser)
          expect(subject).to receive(:run_radon).with(code_directory, raw_parser)
          expect(subject).to receive(:run_radon).with(code_directory, mi_parser)

          subject.collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
        end
      end

      context 'with an unknown metric' do
        let(:wanted_metric_configurations) { { "whatever" => double } }

        it 'is expected to raise an UnavailableMetricError' do
          expect {
            subject.collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
          }.to raise_error(Kolekti::UnavailableMetricError, "Metric does not belong to Radon")
        end
      end
    end

    describe 'clean' do
      xit 'is expected to be implemented' do
        expect { subject.clean(nil, nil) }.to_not raise_error
      end
    end

    describe 'default_value_from' do
      context 'with a known metric' do
        let(:metric_configuration) { pending }

        xit 'is expected to fetch its default value from its parser' do
          expect(subject.default_value_from(metric_configuration)).to eq(
            Kolekti::Radon::Parsers::PARSERS[:pending].default_value)
        end
      end

      context 'with a metric with an invalid type' do
        let(:metric_configuration) { pending }

        xit 'is expected to raise an UnavailableMetricError' do
          expect { subject.default_value_from(metric_configuration) }.to raise_error(Kolekti::UnavailableMetricError,
                                                                                     'Invalid Metric configuration type')
        end
      end

      context 'with a metric that does not belong to Radon' do
        let(:metric_configuration) { FactoryGirl.build(:metric_configuration, metric: FactoryGirl.build(:native_metric)) }

        xit 'is expected to raise an UnavailableMetricError' do
          expect { subject.default_value_from(metric_configuration) }.to raise_error(Kolekti::UnavailableMetricError,
                                                                                     'Metric configuration does not belong to Radon')
        end
      end
    end
  end
end
