require 'rails_helper'

RSpec.describe KalibroRangesController do
  let!(:metric_configuration) { FactoryGirl.build(:tree_metric_configuration_with_id) }
  let!(:reading) { FactoryGirl.build(:reading_with_id) }
  let!(:range) { FactoryGirl.build(:kalibro_range_with_id, metric_configuration_id: metric_configuration.id, reading_id: reading.id) }

  describe 'index' do
    context 'with at least one range' do
      let!(:ranges) { [range] }

      before :each do
        metric_configuration.expects(:kalibro_ranges).returns(ranges)
        MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)

        get :index, metric_configuration_id: metric_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'should return an array of ranges' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({kalibro_ranges: [range]}.to_json))
      end
    end

    context 'without ranges' do
      let!(:ranges) { [] }

      before :each do
        metric_configuration.expects(:kalibro_ranges).returns(ranges)
        MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)

        get :index, metric_configuration_id: metric_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'should return an empty array' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({kalibro_ranges: []}.to_json))
      end
    end

    context 'without a metric configuration' do
      before :each do
        MetricConfiguration.expects(:find).with(metric_configuration.id).raises(ActiveRecord::RecordNotFound)
        get :index, metric_configuration_id: metric_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:not_found) }

      it 'should return the error description' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({errors: ['ActiveRecord::RecordNotFound']}.to_json))
      end
    end
  end

  describe 'show' do
    context 'when the KalibroRange exists' do
      before :each do
        KalibroRange.expects(:find).with(range.id).returns(range)

        get :show, id: range.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return the kalibro_range converted to JSON' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({kalibro_range: range}.to_json))
      end
    end

    context 'when the KalibroRange does not exist' do
      before :each do
        KalibroRange.expects(:find).with(range.id).raises(ActiveRecord::RecordNotFound)

        get :show, id: range.id, format: :json
      end

      it { is_expected.to respond_with(:not_found) }

      it 'should return the error description' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({errors: ['ActiveRecord::RecordNotFound']}.to_json))
      end
    end
  end

  describe 'create' do
    let!(:range_params) {
      FactoryGirl.attributes_for(:kalibro_range,
        metric_configuration_id: metric_configuration.id, reading_id: reading.id,
        beginning: '-INF',
        end: 'INF').stringify_keys
    }

    context 'successfully saved' do
      before :each do
        KalibroRange.any_instance.expects(:save).returns(true)
      end

      context 'json format' do
        before :each do
          post :create, metric_configuration_id: metric_configuration.id, kalibro_range: range_params, format: :json
        end

        it { is_expected.to respond_with(:created) }

        it 'returns the range' do
          range_params['id'] = nil
          range_params['created_at'] = nil
          range_params['updated_at'] = nil
          range_params['metric_configuration_id'] = metric_configuration.id
          range_params['reading_id'] = reading.id
          range_params['beginning'] = (-Float::INFINITY).to_s
          range_params['end'] = Float::INFINITY.to_s
          expect(JSON.parse(response.body)).to eq({'kalibro_range' => range_params})
        end
      end
    end

    context 'failed to save' do
      let!(:range_params) { FactoryGirl.attributes_for(:kalibro_range, metric_configuration_id: metric_configuration.id, reading_id: reading.id).stringify_keys }
      before :each do
        KalibroRange.any_instance.expects(:save).returns(false)
      end

      context 'json format' do
        before :each do
          post :create, metric_configuration_id: metric_configuration.id, kalibro_range: range_params, format: :json
        end

        it { is_expected.to respond_with(:unprocessable_entity) }

        it 'returns an error' do
          expect(JSON.parse(response.body)).to eq(JSON.parse({errors: []}.to_json))
        end
      end
    end
  end

  describe 'update' do
    let!(:range_params) { FactoryGirl.attributes_for(:kalibro_range, metric_configuration_id: metric_configuration.id, reading_id: reading.id).stringify_keys }

    before :each do
      KalibroRange.expects(:find).with(range.id).returns(range)
    end

    context 'successfully updated' do
      before :each do
        KalibroRange.any_instance.expects(:update).with(range_params).returns(true)
      end

      context 'json format' do
        before :each do
          range_params.delete('id')
          put :update, metric_configuration_id: metric_configuration.id, kalibro_range: range_params, id: range.id, format: :json
        end

        it { is_expected.to respond_with(:created) } # TODO: change :created response

        it 'returns the range' do
          expect(JSON.parse(response.body)).to eq(JSON.parse({kalibro_range: range}.to_json))
        end
      end
    end

    context 'failed to update' do
      before :each do
        KalibroRange.any_instance.expects(:update).with(range_params).returns(false)
      end

      context 'json format' do
        before :each do
          range_params.delete('id')
          post :update, metric_configuration_id: metric_configuration.id, kalibro_range: range_params, id: range.id, format: :json
        end

        it { is_expected.to respond_with(:unprocessable_entity) }

        it 'should return the error description' do
          expect(JSON.parse(response.body)).to eq(JSON.parse({errors: []}.to_json))
        end
      end
    end
  end

  describe 'exists' do
    context 'when the kalibro_range exists' do
      before :each do
        KalibroRange.expects(:exists?).with(range.id).returns(true)

        get :exists, id: range.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'should return true' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({exists: true}.to_json))
      end
    end

    context 'when the kalibro_range does not exist' do
      before :each do
        KalibroRange.expects(:exists?).with(range.id).returns(false)

        get :exists, id: range.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'should return false' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({exists: false}.to_json))
      end
    end
  end

  describe 'destroy' do
    context 'with an existent range' do
      before :each do
        KalibroRange.expects(:find).with(range.id).returns(range)
      end

      context 'json format' do
        before :each do
          range.expects(:destroy).returns(true)
          delete :destroy, metric_configuration_id: metric_configuration.id, id: range.id, format: :json
        end

        it { is_expected.to respond_with(:success) }

        it 'returns an empty hash' do
          expect(JSON.parse(response.body)).to eq(JSON.parse({}.to_json))
        end
      end
    end
  end
end
