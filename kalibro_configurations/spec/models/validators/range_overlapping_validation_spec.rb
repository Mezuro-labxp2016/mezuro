require 'rails_helper'
require 'validators/range_overlapping_validator'

RSpec.describe RangeOverlappingValidator do
  describe 'methods' do
    describe 'validate' do
      let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
      subject { FactoryGirl.build(:kalibro_range, beginning: 100.0, end: Float::INFINITY) }
      context 'not overlapping' do
        let!(:not_overlapping_range) { FactoryGirl.build(:kalibro_range, id: 2, beginning: -Float::INFINITY, end: -190.0, metric_configuration_id: metric_configuration.id) }
        before :each do
          subject.metric_configuration.expects(:kalibro_ranges).returns([subject, not_overlapping_range])
        end
        it 'is expected to not return errors' do
          subject.save
          expect(subject.errors).to be_empty
        end
      end
    end

    describe 'overlaps' do
      let!(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
      let!(:range) { FactoryGirl.build(:kalibro_range, metric_configuration: metric_configuration) }
      before :each do
        metric_configuration.expects(:kalibro_ranges).returns([range, overlapping_range])
      end

      context 'equal intervals' do
        let!(:overlapping_range) { FactoryGirl.build(:kalibro_range, id: 2, metric_configuration: metric_configuration) }
        it 'is expected to return errors' do
          range.save
          expect(range.errors[:beginning]).to eq(["There is already a #{range.class} within these boundaries! Please, choose another interval."])
        end
      end

      context 'contained intervals' do
        let!(:overlapping_range) { FactoryGirl.build(:kalibro_range, id: 2, metric_configuration: metric_configuration, beginning: 1.0, end: 1.4) }
        it 'is expected to return errors' do
          range.save
          expect(range.errors[:beginning]).to eq(["There is already a #{range.class} within these boundaries! Please, choose another interval."])
        end
      end

      context 'intervals with intersection' do
        let!(:overlapping_range) { FactoryGirl.build(:kalibro_range, id: 2, metric_configuration: metric_configuration, beginning: 0.4, end: 1.0) }
        it 'is expected to return errors' do
          range.save
          expect(range.errors[:beginning]).to eq(["There is already a #{range.class} within these boundaries! Please, choose another interval."])
        end
      end

      context 'boundary contained interval' do
        let!(:overlapping_range) { FactoryGirl.build(:kalibro_range, id: 2, metric_configuration: metric_configuration, beginning: 0.5, end: 1.4) }
        it 'is expected to return errors' do
          range.save
          expect(range.errors[:beginning]).to eq(["There is already a #{range.class} within these boundaries! Please, choose another interval."])
        end
      end
    end
  end
end
