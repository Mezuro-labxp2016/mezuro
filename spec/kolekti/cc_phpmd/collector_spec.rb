require 'tmpdir'
require 'fileutils'

require 'spec_helper'
require 'kalibro_client'
require 'kolekti'

describe Kolekti::CcPhpMd::Collector do
  describe 'class_method' do
    describe 'available' do
      context 'with the collector available' do
        before do
          expect(described_class).to receive(:system).with(/codeclimate/, any_args) { true }
        end

        it 'is expected to return true' do
          expect(described_class.available?).to be_truthy
        end
      end
    end
  end

  describe 'methods' do
    describe 'initialize' do
      let(:supported_metrics) { double }

      it 'is expected to load the supported metrics' do
        expect_any_instance_of(described_class).to receive(:parse_supported_metrics).with(
          /\/metrics\.yml$/, 'CodeClimate PHPMD', [:PHP]) { supported_metrics }

        subject = described_class.new
        expect(subject.supported_metrics).to eq(supported_metrics)
      end
    end
  end

  describe 'config' do
    it 'is expected to create a CC configuration that will be used by the EnginesRunner' do
      expect(Kolekti::CcPhpMd::Collector.config).to be_a(CC::Yaml::Nodes::Root)
    end
  end

  describe 'collect_metrics' do
    let(:persistence_strategy) { FactoryGirl.build(:persistence_strategy) }
    let(:wanted_metric_configurations) { double }
    let(:code_directory) { '/tmp' }
    let(:runner) { double }

    it 'is expected to instantiate the right CC objects and run the PHPMD collector' do
      expect(Kolekti::CcPhpMd::Parser).to receive(:new).with(subject, wanted_metric_configurations, persistence_strategy)
      expect(Dir).to receive(:chdir).with(code_directory).and_yield
      expect_any_instance_of(CC::Analyzer::EnginesRunner).to receive(:run)

      subject.collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
    end
  end
end
