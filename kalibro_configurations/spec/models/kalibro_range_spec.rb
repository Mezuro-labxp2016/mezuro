require 'rails_helper'
require 'mocha/test_unit'

RSpec.describe KalibroRange do
  describe 'associations' do
    it { is_expected.to belong_to(:reading) }
    it { is_expected.to belong_to(:metric_configuration) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:beginning) }
    it { is_expected.to validate_presence_of(:end) }
    it { is_expected.to validate_presence_of(:metric_configuration) }
    it { is_expected.to validate_presence_of(:reading) }
    it { is_expected.to validate_numericality_of(:beginning) }
    it { is_expected.to validate_numericality_of(:end) }
    it {
      is_expected.to validate_uniqueness_of(:beginning)
        .scoped_to(:metric_configuration_id).with_message('Should be unique within a Metric Configuration')
    }

    context 'with invalid beginning or end' do
      subject { FactoryGirl.build(:kalibro_range_with_id) }

      @cases = [
        [Float::INFINITY, Float::INFINITY],
        [Float::INFINITY, -Float::INFINITY],
        [-Float::INFINITY, -Float::INFINITY]
      ]

      @cases.each do |beginning, end_|
        context "with beggining #{beginning} and end #{end_}" do
          it 'should fail to validate' do
            subject.beginning = beginning
            subject.end = end_
            expect(subject.valid?).to be_falsey
          end
        end
      end
    end
  end

  describe 'methods' do
    describe 'as_json' do
      subject { FactoryGirl.build(:kalibro_range_with_id) }

      context 'with numbers' do
        it 'is expected to convert the numbers to strings' do
          expect(KalibroRange.new(subject.as_json)).to eq(subject)
        end
      end

      context 'with negative infinity beginning' do
        before do
          subject.beginning = -Float::INFINITY
        end

        it 'is expected to convert to -INF' do
          expect(subject.as_json['beginning']).to eq('-INF')
        end
      end

      context 'with positive infinity end' do
        before do
          subject.end = Float::INFINITY
        end

        it 'is expected to convert to INF' do
          expect(subject.as_json['end']).to eq('INF')
        end
      end

      context 'with negative infinity end' do
        before do
          subject.end = -Float::INFINITY
        end

        it 'is expected to convert to INF' do
          expect(subject.as_json['end']).to eq('-INF')
        end
      end
    end
  end

  describe 'setters' do
    subject { FactoryGirl.build(:kalibro_range) }

    describe 'beginning' do
      it 'should convert "-INF" to -Float::INFINITY' do
        subject.beginning = '-INF'

        expect(subject.beginning).to eq(-Float::INFINITY)
      end

      it 'should convert "INF" to Float::INFINITY' do
        subject.beginning = 'INF'

        expect(subject.beginning).to eq(Float::INFINITY)
      end

      it 'is expected to convert any numerical string to a float instance' do
        subject.beginning = '123.3'

        expect(subject.beginning).to eq(123.3)
      end
    end

    describe 'end' do
      it 'should convert "-INF" to -Float::INFINITY' do
        subject.end = '-INF'

        expect(subject.end).to eq(-Float::INFINITY)
      end

      it 'should convert "INF" to Float::INFINITY' do
        subject.end = 'INF'

        expect(subject.end).to eq(Float::INFINITY)
      end

      it 'is expected to convert any numerical string to a float instance' do
        subject.end = '123.3'

        expect(subject.end).to eq(123.3)
      end
    end
  end
end
