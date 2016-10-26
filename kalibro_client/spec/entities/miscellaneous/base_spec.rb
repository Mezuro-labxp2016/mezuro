require 'spec_helper'

describe KalibroClient::Entities::Miscellaneous::Base, :type => :model do
  subject {FactoryGirl.build(:misc_model)}
  describe 'methods' do
    describe 'to_hash' do
      it 'should return an empty hash' do
        expect(subject.to_hash).to be_empty
      end
    end

    describe 'to_object' do
      it 'should return an Object with an empty hash' do
        expect(KalibroClient::Entities::Miscellaneous::Base.to_object({})).to eq(FactoryGirl.build(:misc_model))
      end

      it "should remain an object if it isn't a Hash" do
        expect(KalibroClient::Entities::Miscellaneous::Base.to_object(Object.new)).to be_an(Object)
      end
    end

    describe '==' do
      context 'comparing objects from different classes' do
        it 'should return false' do
          expect(subject).not_to eq(Object.new)
        end
      end

      context 'with two models with different attribute values' do
        let(:another_model) { FactoryGirl.build(:misc_model) }
        before :each do
          subject.expects(:variable_names).returns(["answer"])
          subject.expects(:send).with("answer").returns(42)
          another_model.expects(:send).with("answer").returns(41)
        end 

        it 'should return false' do
          expect(subject).not_to eq(another_model)
        end
      end

      context 'with two empty models' do
        it 'should return true' do
          expect(subject).to eq(FactoryGirl.build(:misc_model))
        end
      end
    end
  end
end