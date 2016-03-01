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
end