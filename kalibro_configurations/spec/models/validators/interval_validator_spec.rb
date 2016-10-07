require 'rails_helper'
require 'validators/interval_validator'

RSpec.describe IntervalValidator do
  describe 'methods' do
    describe 'validate' do
      context 'when beginning is Infinity or end is -Infinity' do
        subject { FactoryGirl.build(:kalibro_range, end: -Float::INFINITY) }
        it 'is expected to return an error' do
          subject.save
          expect(subject.errors['end']).to eq(['The End value should be greater than the Beginning value.'])
        end
      end
      context 'when beginning is -Infinity or end is Infinity' do
        subject { FactoryGirl.build(:kalibro_range, end: Float::INFINITY) }
        it 'is expected to not return an error' do
          subject.save
          expect(subject.errors['end']).to be_empty
        end
      end
      context 'when beginning is greater than end' do
        subject { FactoryGirl.build(:kalibro_range, beginning: 1.0, end: 0.0) }
        it 'is expected to return an error' do
          subject.save
          expect(subject.errors['end']).to eq(['The End value should be greater than the Beginning value.'])
        end
      end
      context 'when beginning is smaller than end' do
        subject { FactoryGirl.build(:kalibro_range) }
        it 'is expected to not return an error' do
          subject.save
          expect(subject.errors['end']).to be_empty
        end
      end
    end
  end
end
