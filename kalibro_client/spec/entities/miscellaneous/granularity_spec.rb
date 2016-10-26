require 'spec_helper'

describe KalibroClient::Entities::Miscellaneous::Granularity do
  describe 'method' do
    describe 'initialize' do
      context 'with a valid type' do
        it 'should return an instance of Granularity' do
          expect(KalibroClient::Entities::Miscellaneous::Granularity.new(:SOFTWARE)).to be_a(KalibroClient::Entities::Miscellaneous::Granularity)
        end
      end

      context 'with a invalid type' do
        it 'should raise a TypeError' do
          expect { KalibroClient::Entities::Miscellaneous::Granularity.new(:MCC) }.to raise_error(TypeError)
        end
      end
    end

    describe 'parent' do
      context 'with a SOFTWARE granularity' do
        subject { FactoryGirl.build(:granularity) }

        it 'should return SOFTWARE' do
          expect(subject.parent.type).to eq(KalibroClient::Entities::Miscellaneous::Granularity::SOFTWARE)
        end
      end

      context 'with a METHOD granularity' do
        subject { FactoryGirl.build(:granularity, type: KalibroClient::Entities::Miscellaneous::Granularity::METHOD) }

        it 'should return CLASS' do
          expect(subject.parent.type).to eq(KalibroClient::Entities::Miscellaneous::Granularity::CLASS)
        end
      end

      context 'with a FUNCTION granularity' do
        subject { FactoryGirl.build(:granularity, type: KalibroClient::Entities::Miscellaneous::Granularity::FUNCTION) }

        it 'should return PACKAGE' do
          expect(subject.parent.type).to eq(KalibroClient::Entities::Miscellaneous::Granularity::PACKAGE)
        end
      end
    end

    describe 'Comparison Operators' do
      subject { FactoryGirl.build(:granularity, type: KalibroClient::Entities::Miscellaneous::Granularity::CLASS) }
      context 'comparing to a greater one' do
        let(:other_granularity) { FactoryGirl.build(:granularity, type: KalibroClient::Entities::Miscellaneous::Granularity::SOFTWARE) }
        it 'should return true when checking for <' do
          expect(subject < other_granularity).to be_truthy
        end
        it 'should return true when checking for <=' do
          expect(subject <= other_granularity).to be_truthy
        end
        it 'should return false when checking for >' do
          expect(subject > other_granularity).to be_falsey
        end
        it 'should return false when checking for >=' do
          expect(subject >= other_granularity).to be_falsey
        end
        it 'should return -1 when checking for <=>' do
          expect(subject <=> other_granularity).to eq(-1)
        end
      end

      context 'comparing to an equal one' do
        let(:other_granularity) { FactoryGirl.build(:granularity, type: KalibroClient::Entities::Miscellaneous::Granularity::CLASS) }
        it 'should return false when checking for <' do
          expect(subject < other_granularity).to be_falsey
        end
        it 'should return true when checking for <=' do
          expect(subject <= other_granularity).to be_truthy
        end
        it 'should return false when checking for >' do
          expect(subject > other_granularity).to be_falsey
        end
        it 'should return true when checking for >=' do
          expect(subject >= other_granularity).to be_truthy
        end
        it 'should return 0 when checking for <=>' do
          expect(subject <=> other_granularity).to eq(0)
        end
      end

      context 'comparing to a smaller one' do
        let(:other_granularity) { FactoryGirl.build(:granularity, type: KalibroClient::Entities::Miscellaneous::Granularity::METHOD) }
        it 'should return false when checking for <' do
          expect(subject < other_granularity).to be_falsey
        end
        it 'should return false when checking for <=' do
          expect(subject <= other_granularity).to be_falsey
        end
        it 'should return true when checking for >' do
          expect(subject > other_granularity).to be_truthy
        end
        it 'should return true when checking for >=' do
          expect(subject >= other_granularity).to be_truthy
        end
        it 'should return 1 when checking for <=>' do
          expect(subject <=> other_granularity).to eq(1)
        end
      end

      context 'comparing unrelated ones' do
        let(:function_granularity) { FactoryGirl.build(:granularity, type: KalibroClient::Entities::Miscellaneous::Granularity::FUNCTION) }
        let(:method_granularity) { FactoryGirl.build(:granularity, type: KalibroClient::Entities::Miscellaneous::Granularity::METHOD) }
        let(:class_granularity) { FactoryGirl.build(:granularity, type: KalibroClient::Entities::Miscellaneous::Granularity::CLASS) }

        it 'should raise an ArgumentError' do
          expect { function_granularity < method_granularity }.to raise_error(ArgumentError)
          expect { function_granularity <= method_granularity }.to raise_error(ArgumentError)
          expect { function_granularity >= method_granularity }.to raise_error(ArgumentError)
          expect { function_granularity > method_granularity }.to raise_error(ArgumentError)
          expect { function_granularity < class_granularity }.to raise_error(ArgumentError)
          expect { function_granularity <= class_granularity }.to raise_error(ArgumentError)
          expect { function_granularity >= class_granularity }.to raise_error(ArgumentError)
          expect { function_granularity > class_granularity }.to raise_error(ArgumentError)
        end
      end
    end

    describe 'to_s' do
      subject { FactoryGirl.build(:granularity) }

      it 'is expected to return the type as a string' do
        expect(subject.to_s).to eq(subject.type.to_s)
      end
    end
  end
end
