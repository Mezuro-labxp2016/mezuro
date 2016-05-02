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

    describe 'logger' do
      it 'is expected to return a Logger with the progname set' do
        result = described_class.logger
        expect(result).to be_a(Logger)
        expect(result.progname).to eq('kolekti/radon')
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
        let(:logger) { instance_double(Logger) }
        let(:cc_parser) { instance_double(Kolekti::Radon::Parser::Cyclomatic) }
        let(:mi_parser) { instance_double(Kolekti::Radon::Parser::Maintainability) }
        let(:raw_parser) { instance_double(Kolekti::Radon::Parser::Raw) }
        let(:cc_metric_configuration) { FactoryGirl.build(:cyclomatic_metric_configuration) }
        let(:mi_metric_configuration) { FactoryGirl.build(:maintainability_metric_configuration) }
        let(:raw_metric_configurations) { {
          "loc" => FactoryGirl.build(:lines_of_code_metric_configuration),
          "lloc" => FactoryGirl.build(:logical_lines_of_code_metric_configuration)
        } }
        let(:wanted_metric_configurations) {
          {"cc" => cc_metric_configuration, "mi" => mi_metric_configuration}.merge(raw_metric_configurations)
        }

        it 'is expected to collect and parse all metrics' do
          expect(described_class).to receive(:logger).and_return(logger).exactly(3).times

          expect(Kolekti::Radon::Parser::Cyclomatic).to receive(:new).
            with([cc_metric_configuration], persistence_strategy, logger).and_return(cc_parser)
          expect(Kolekti::Radon::Parser::Maintainability).to receive(:new).
            with([mi_metric_configuration], persistence_strategy, logger).and_return(mi_parser)
          expect(Kolekti::Radon::Parser::Raw).to receive(:new).
            with(raw_metric_configurations.values, persistence_strategy, logger).and_return(raw_parser)

          expect(subject).to receive(:run_radon).with(code_directory, cc_parser)
          expect(subject).to receive(:run_radon).with(code_directory, raw_parser)
          expect(subject).to receive(:run_radon).with(code_directory, mi_parser)

          subject.collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
        end
      end

      context 'with an unknown metric' do
        let(:wanted_metric_configurations) { { "whatever" => FactoryGirl.build(:metric_configuration) } }

        it 'is expected to raise an UnavailableMetricError' do
          expect {
            subject.collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
          }.to raise_error(Kolekti::UnavailableMetricError)
        end
      end
    end

    describe 'clean' do
      it 'is expected to be implemented' do
        expect { subject.clean(nil, nil) }.to_not raise_error
      end
    end

    describe 'default_value_from' do
      context 'with a known metric' do
        let(:metric_configuration) { FactoryGirl.build(:cyclomatic_metric_configuration) }

        it 'is expected to fetch its default value from its parser' do
          expect(subject.default_value_from(metric_configuration)).to eq(
            Kolekti::Radon::Parsers::PARSERS[:cc].default_value)
        end
      end

      context 'with a metric with an invalid type' do
        let(:metric_configuration) { pending }

        it 'is expected to raise an UnavailableMetricError' do
          expect { subject.default_value_from(metric_configuration) }.to raise_error(Kolekti::UnavailableMetricError,
                                                                                     'Invalid Metric configuration type')
        end
      end

      context 'with a metric that does not belong to Radon' do
        let(:metric_configuration) { FactoryGirl.build(:metric_configuration, metric: FactoryGirl.build(:native_metric)) }

        it 'is expected to raise an UnavailableMetricError' do
          expect { subject.default_value_from(metric_configuration) }.to raise_error(Kolekti::UnavailableMetricError,
                                                                                     'Metric configuration does not belong to Radon')
        end
      end
    end

    describe 'run_radon' do
      let(:command_params) { [['radon', 'raw', '.', '--json'], chdir: code_directory] }
      let(:code_directory) { '/tmp/test'}
      let(:parser) { instance_double(Kolekti::Radon::Parser::Raw, command: 'raw') }
      let(:results) { instance_double(IO, pid: 1234) }
      let(:radon_status) { 0 }

      before :each do
        expect(IO).to receive(:popen).with(*command_params).and_return(results).ordered
        expect(results).to receive(:close).ordered
        is_expected.to receive(:last_process_exitstatus).and_return(radon_status).ordered
      end

      context 'with a successful radon run' do
        let(:parsed_results) { double }

        context 'when the JSON is valid' do 
          it 'is expected to call the parser with the results' do
            expect(JSON).to receive(:load).with(results).and_return(parsed_results)
            expect(parser).to receive(:parse).with(parsed_results)

            subject.send(:run_radon, code_directory, parser)
          end
        end

        context 'when the JSON is invalid' do
          it 'is expected to raise an CollectorError' do
            expect(JSON).to receive(:load).with(results).and_raise(JSON::JSONError)

            expect {
              subject.send(:run_radon, code_directory, parser)
            }.to raise_error(Kolekti::CollectorError, 'Error while parsing Radon output')
          end
        end
      end

      context 'with a failed radon run' do
        let(:radon_status) { 1 }

        it 'is expected to raise an CollectorError' do
          expect(JSON).to receive(:load).with(results)

          expect {
            subject.send(:run_radon, code_directory, parser)
          }.to raise_error(Kolekti::CollectorError, 'Radon failed')
        end
      end
    end
  end
end
