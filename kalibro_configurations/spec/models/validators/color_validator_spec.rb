require 'rails_helper'
require 'validators/color_validator'

RSpec.describe ColorValidator do
  describe 'methods' do
    describe 'validate' do
      context 'when the color is valid' do
        subject { FactoryGirl.build(:reading, color: 'a9F0b2') }
        it 'is not expected to return an error' do
          subject.save
          expect(subject.errors['color']).to be_empty
        end
      end
      context 'when the color is not valid' do
        subject { FactoryGirl.build(:reading, color: 'aaa') }
        it 'is expected to return an error when color does not have exactly 6 digits' do
          subject.save
          expect(subject.errors['color']).to eq(['Color must be hexadecimal'])
        end

        subject { FactoryGirl.build(:reading, color: 'GGGGGG') }
        it 'is expected to return an error when color is not hexadecimal' do
          subject.save
          expect(subject.errors['color']).to eq(['Color must be hexadecimal'])
        end
      end
    end
  end
end
