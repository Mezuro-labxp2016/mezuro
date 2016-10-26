require 'spec_helper'

describe KalibroClient::Entities::Miscellaneous::Metric, :type => :model do
  describe 'methods' do
    describe 'initialize' do
      it 'should return an instance of Metric' do
        compound = true
        name = "Sample name"
        code = "sample_code"
        scope = KalibroClient::Entities::Miscellaneous::Granularity.new(:SOFTWARE)
        expect(KalibroClient::Entities::Miscellaneous::Metric.new(compound, name, code, scope)).to be_a(KalibroClient::Entities::Miscellaneous::Metric)
      end
    end

    describe 'scope=' do
      subject { FactoryGirl.build(:metric) }
      context 'with a valid granularity' do
        it 'is expected to instantiate a Granularity' do
          subject.scope = {"type" => "CLASS"}
          expect(subject.scope).to be_a KalibroClient::Entities::Miscellaneous::Granularity
        end
      end

      context 'with an invalid granularity' do
        it 'is expected to raise a TypeError' do
          scope = nil
          expect { subject.scope = scope }.to raise_error TypeError
        end
      end
    end
  end
end
