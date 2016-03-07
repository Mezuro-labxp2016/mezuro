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
end
