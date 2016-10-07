require 'rails_helper'

RSpec.describe MetricConfigurationsController do
  let(:metric_configuration) { FactoryGirl.build(:tree_metric_configuration_with_id) }

  describe 'create' do
    let!(:metric_configuration_params) {
      FactoryGirl.attributes_for(:tree_metric_configuration,
        kalibro_configuration_id: metric_configuration.kalibro_configuration.id).stringify_keys
    }

    # The condition is needed for these workaround is not recursive and MetricSnapshot#scope=
    # requires the scope param to be a Hash, not a String. Otherwise it will add an error
    # to the created instance.
    let!(:metric_snapshot_params) { FactoryGirl.attributes_for(:metric_snapshot).stringify_keys }

    context 'with valid params' do
      before :each do
        KalibroConfiguration.expects(:find).with(metric_configuration.kalibro_configuration_id).returns(metric_configuration.kalibro_configuration)
        metric_configuration_params.delete('metric_snapshot')
        metric_configuration_params['metric'] = metric_snapshot_params.clone
        metric_configuration_params['metric']['type'] = 'NativeMetricSnapshot'
        MetricConfiguration.any_instance.expects(:save).returns(true)
        metric_configuration.metric_snapshot.id = 1
        MetricSnapshot.expects(:create).with(metric_snapshot_params).returns(metric_configuration.metric_snapshot)

        post :create, metric_configuration: metric_configuration_params, format: :json
      end

      it { is_expected.to respond_with(:created) }

      it 'is expected to return the MetricConfiguration' do
        metric_configuration.id = nil
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_configuration: metric_configuration}.to_json))
      end
    end

    context 'with invalid params' do
      context 'for MetricConfiguration' do
        before :each do
          KalibroConfiguration.expects(:find).with(metric_configuration.kalibro_configuration_id).returns(metric_configuration.kalibro_configuration)
          MetricConfiguration.any_instance.expects(:save).returns(false)
          metric_configuration.metric_snapshot.id = 1
          MetricSnapshot.expects(:create).with(metric_snapshot_params).returns(metric_configuration.metric_snapshot)
          metric_configuration_params['metric'] = metric_snapshot_params

          post :create, metric_configuration: metric_configuration_params, format: :json
        end

        it { is_expected.to respond_with(:unprocessable_entity) }

        it 'should return the error description with the metric_configuration' do
          metric_configuration.id = nil
          expect(JSON.parse(response.body)).to eq(JSON.parse({errors: []}.to_json))
        end
      end

      context 'for MetricSnapshot' do
        before :each do
          MetricSnapshot.expects(:create).with(metric_snapshot_params).returns(metric_configuration.metric_snapshot)
          metric_configuration_params['metric'] = metric_snapshot_params

          post :create, metric_configuration: metric_configuration_params, format: :json
        end

        it { is_expected.to respond_with(:unprocessable_entity) }

        it 'should return the error description with the metric_configuration' do
          expect(JSON.parse(response.body)).to eq(JSON.parse({errors: []}.to_json))
        end
      end
    end
  end

  describe 'update' do
    let(:metric_configuration_params) {
      FactoryGirl.attributes_for(:metric_configuration,
        kalibro_configuration_id: metric_configuration.kalibro_configuration.id,
        metric_snapshot_id: metric_configuration.metric_snapshot.id).stringify_keys
    }

    before :each do
      metric_configuration.metric_snapshot.id = 1
      MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
    end

    context 'with valid attributes' do
      context 'with a NativeMetricSnapshot' do
        before :each do
          metric_configuration_params.delete('id')
          metric_configuration_params.delete('metric_snapshot_id')
          MetricConfiguration.any_instance.expects(:update).with(metric_configuration_params).returns(true)

          put :update, metric_configuration: metric_configuration_params, id: metric_configuration.id, format: :json
        end

        it { is_expected.to respond_with(:created) }

        it 'is expected to return the metric_configuration' do
          expect(JSON.parse(response.body)).to eq(JSON.parse({metric_configuration: metric_configuration}.to_json))
        end
      end

      context 'with a CompoundMetricSnapshot' do
        # The condition is needed for these workaround is not recursive and MetricSnapshot#scope=
        # requires the scope param to be a Hash, not a String. Otherwise it will add an error
        # to the created instance.
        let!(:metric_snapshot_params) { FactoryGirl.attributes_for(:compound_metric_snapshot).stringify_keys }
        let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration) }

        before :each do
          metric_configuration.metric_snapshot = FactoryGirl.build(:compound_metric_snapshot)
          metric_configuration.metric_snapshot.expects(:destroy)
          metric_configuration.expects(:save)

          metric_configuration_params.delete('id')
          metric_configuration_params.delete('metric_snapshot_id')
          KalibroConfiguration.expects(:find).with(metric_configuration.kalibro_configuration_id).returns(kalibro_configuration)
          kalibro_configuration.expects(:metric_configurations).returns([metric_configuration])
          MetricConfiguration.any_instance.expects(:update).with(metric_configuration_params.clone).returns(true)
          metric_configuration_params['metric'] = metric_snapshot_params.clone
          metric_configuration_params['metric']['type'] = 'CompoundMetricSnapshot'
          MetricSnapshot.expects(:create).with(metric_snapshot_params).returns(metric_configuration.metric_snapshot)

          put :update, metric_configuration: metric_configuration_params, id: metric_configuration.id, format: :json
        end

        it { is_expected.to respond_with(:created) }

        it 'is expected to return the metric_configuration' do
          expect(JSON.parse(response.body)).to eq(JSON.parse({metric_configuration: metric_configuration}.to_json))
        end
      end
    end

    context 'with invalid attributes' do
      before :each do
        metric_configuration_params.delete('id')
        metric_configuration_params.delete('metric_snapshot_id')
        MetricConfiguration.any_instance.expects(:update).with(metric_configuration_params).returns(false)

        put :update, metric_configuration: metric_configuration_params, id: metric_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:unprocessable_entity) }

      it 'should return the error description' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({errors: []}.to_json))
      end
    end
  end

  describe 'destroy' do
    before :each do
      metric_configuration.expects(:destroy).returns(true)
      MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)

      delete :destroy, id: metric_configuration.id, format: :json
    end
    it { is_expected.to respond_with(:success) }
  end

  describe 'exists' do
    context 'when the metric configuration exists' do
      before :each do
        MetricConfiguration.expects(:exists?).with(metric_configuration.id).returns(true)

        get :exists, id: metric_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'should return true' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({exists: true}.to_json))
      end
    end

    context 'when the metric configuration does not exist' do
      before :each do
        MetricConfiguration.expects(:exists?).with(metric_configuration.id).returns(false)

        get :exists, id: metric_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'should return false' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({exists: false}.to_json))
      end
    end
  end

  describe 'show' do
    context 'when the MetricConfiguration exists' do
      before :each do
        MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)

        get :show, id: metric_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return the list of metric_configurations converted to JSON' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_configuration: metric_configuration}.to_json))
      end
    end

    context 'when the MetricConfiguration does not exist' do
      before :each do
        MetricConfiguration.expects(:find).with(metric_configuration.id).raises(ActiveRecord::RecordNotFound)

        get :show, id: metric_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:not_found) }

      it 'should return the error description' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({errors: ['ActiveRecord::RecordNotFound']}.to_json))
      end
    end
  end
end
