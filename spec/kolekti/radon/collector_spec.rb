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

      xit 'is expected to load the supported metrics' do
        expect_any_instance_of(described_class).to receive(:parse_supported_metrics).with(
          /\/metrics\.yml$/, 'Radon', [:PYTHON]) { supported_metrics }

        subject = described_class.new
        expect(subject.supported_metrics).to eq(supported_metrics)
      end
    end

    describe 'collect_metrics' do
      let(:code_directory) { "/tmp/test" }
      let(:output_path) { code_directory + '/radon843-8392-92849382--0.json' }
      let(:tempfile) { instance_double(Tempfile) }
      let(:wanted_metric_configurations) { double }
      let(:persistence_strategy) { double }
      let(:radon_params) { pending }

      before :each do
        expect(Tempfile).to receive(:new).with(['radon', '.json'], code_directory).and_return(tempfile)
        expect(tempfile).to receive(:close!)
        expect(Dir).to receive(:chdir).with(code_directory).and_yield
      end

      context 'when collecting is successful' do
        xit 'is expected to collect and parse all metrics' do
          expect(tempfile).to receive(:path).twice.and_return(output_path)
          is_expected.to receive(:system).with(*radon_params).and_return(true)
          expect(Kolekti::Radon::Parsers).to receive(:parse_all).with(output_path, wanted_metric_configurations,
                                                                      persistence_strategy)

          subject.collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
        end
      end

      context 'when collecting fails' do
        xit 'is expected to raise a Collector Error' do
          expect(tempfile).to receive(:path).once.and_return(output_path)
          is_expected.to receive(:system).with(*radon_params).and_return(false)
          expect(Kolekti::Radon::Parsers).to receive(:parse_all).never

          expect {
            subject.collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
          }.to raise_error(Kolekti::CollectorError, 'Radon failed')
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
