require 'spec_helper'

describe KalibroClient::Entities::Miscellaneous::CompoundMetric, :type => :model do
  describe 'methods' do
    describe 'initialize' do
      context 'with valid attributes' do
        name = "Sample name"
        code = "sample_code"
        scope = KalibroClient::Entities::Miscellaneous::Granularity.new(:SOFTWARE)
        script = "return 0;"
        compound_metric = KalibroClient::Entities::Miscellaneous::CompoundMetric.new(name, code, scope, script)

        it 'should return an instance of CompoundMetric' do
          expect(compound_metric).to be_a(KalibroClient::Entities::Miscellaneous::CompoundMetric)
        end
      end
    end

    describe 'to_object' do
      subject{ FactoryGirl.build(:compound_metric) }

      context 'with a hash' do
        it 'is expected to create a object from the hash' do
          subject_hash = subject.to_hash
          expect(KalibroClient::Entities::Miscellaneous::CompoundMetric.to_object(subject_hash)).to eq(subject)
        end
      end

      context 'with a metric' do
        it 'is expected to be the same object as the argument' do
          expect(KalibroClient::Entities::Miscellaneous::CompoundMetric.to_object(subject)).to eq(subject)
        end
      end
    end
  end
end
