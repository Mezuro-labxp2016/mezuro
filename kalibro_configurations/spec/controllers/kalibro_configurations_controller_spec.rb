require 'rails_helper'

RSpec.describe KalibroConfigurationsController do
  let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration_with_id) }

  describe 'all' do
    let!(:kalibro_configurations) { [kalibro_configuration] }

    before :each do
      KalibroConfiguration.expects(:all).returns(kalibro_configurations)

      get :all, format: :json
    end

    it { is_expected.to respond_with(:success) }

    it 'is expected to return the list of kalibro_configurations converted to JSON' do
      expect(JSON.parse(response.body)).to eq(JSON.parse({kalibro_configurations: kalibro_configurations}.to_json))
    end
  end

  describe 'show' do
    context 'when the KalibroConfiguration exists' do
      before :each do
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)

        get :show, id: kalibro_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return the list of kalibro_configurations converted to JSON' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({kalibro_configuration: kalibro_configuration}.to_json))
      end
    end

    context 'when the KalibroConfiguration does not exist' do
      before :each do
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).raises(ActiveRecord::RecordNotFound)

        get :show, id: kalibro_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:not_found) }

      it 'is expected to return the error description' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({ errors: ['ActiveRecord::RecordNotFound'] }.to_json))
      end
    end
  end

  describe 'create' do
    let(:kalibro_configuration_params) { FactoryGirl.attributes_for(:kalibro_configuration).stringify_keys }

    context 'with valid attributes' do
      before :each do
        KalibroConfiguration.any_instance.expects(:save).returns(true)

        post :create, kalibro_configuration: kalibro_configuration_params, format: :json
      end

      it { is_expected.to respond_with(:created) }

      it 'is expected to return the kalibro_configuration' do
        kalibro_configuration.id = nil
        expect(JSON.parse(response.body)).to eq(JSON.parse({kalibro_configuration: kalibro_configuration}.to_json))
      end
    end

    context 'with invalid attributes' do
      before :each do
        KalibroConfiguration.any_instance.expects(:save).returns(false)

        post :create, kalibro_configuration: kalibro_configuration_params, format: :json
      end

      it { is_expected.to respond_with(:unprocessable_entity) }

      it 'is expected to return the error description' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({errors: []}.to_json))
      end
    end
  end

  describe 'update' do
    let(:kalibro_configuration_params) { FactoryGirl.attributes_for(:kalibro_configuration).stringify_keys }

    before :each do
      KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)
    end

    context 'with valid attributes' do
      before :each do
        kalibro_configuration_params.delete('id')
        KalibroConfiguration.any_instance.expects(:update).with(kalibro_configuration_params).returns(true)

        put :update, kalibro_configuration: kalibro_configuration_params, id: kalibro_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:created) }

      it 'is expected to return the kalibro_configuration' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({kalibro_configuration: kalibro_configuration}.to_json))
      end
    end

    context 'with invalid attributes' do
      before :each do
        kalibro_configuration_params.delete('id')
        KalibroConfiguration.any_instance.expects(:update).with(kalibro_configuration_params).returns(false)

        put :update, kalibro_configuration: kalibro_configuration_params, id: kalibro_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:unprocessable_entity) }

      it 'is expected to return the error description' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({errors: []}.to_json))
      end
    end
  end

  describe 'exists' do
    context 'when the kalibro_configuration exists' do
      before :each do
        KalibroConfiguration.expects(:exists?).with(kalibro_configuration.id).returns(true)

        get :exists, id: kalibro_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return true' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({exists: true}.to_json))
      end
    end

    context 'when the kalibro_configuration does not exist' do
      before :each do
        KalibroConfiguration.expects(:exists?).with(kalibro_configuration.id).returns(false)

        get :exists, id: kalibro_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return the error description with the kalibro_configuration' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({exists: false}.to_json))
      end
    end
  end

  describe 'metric_configurations' do
    context 'with at least 1 metric configuration' do
      let!(:metric_configuration) { FactoryGirl.build(:tree_metric_configuration, id: 1, kalibro_configuration: kalibro_configuration) }
      let!(:metric_configurations) { [metric_configuration] }
      before :each do
        kalibro_configuration.expects(:metric_configurations).returns(metric_configurations)
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)

        get :metric_configurations, id: kalibro_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return an array of metric_configurations' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_configurations: [metric_configuration]}.to_json))
      end
    end

    context 'without metric configurations' do
      let!(:metric_configurations) { [] }
      before :each do
        kalibro_configuration.expects(:metric_configurations).returns(metric_configurations)
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)

        get :metric_configurations, id: kalibro_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return an empty array' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_configurations: []}.to_json))
      end
    end
  end

  describe 'hotspot_metric_configurations' do
    context 'with at least 1 hotspot_metric configuration' do
      let!(:hotspot_metric_configuration) { FactoryGirl.build(:hotspot_metric_configuration_with_id, kalibro_configuration: kalibro_configuration) }
      let!(:hotspot_metric_configurations) { [hotspot_metric_configuration] }

      before :each do
        kalibro_configuration.expects(:hotspot_metric_configurations).returns(hotspot_metric_configurations)
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)

        get :hotspot_metric_configurations, id: kalibro_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return an array of hotspot_metric_configurations' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({ hotspot_metric_configurations: [hotspot_metric_configuration] }.to_json))
      end
    end

    context 'without hotspot metric configurations' do
      let!(:hotspot_metric_configurations) { [] }
      before :each do
        kalibro_configuration.expects(:hotspot_metric_configurations).returns(hotspot_metric_configurations)
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)

        get :hotspot_metric_configurations, id: kalibro_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return an empty array' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({ hotspot_metric_configurations: [] }.to_json))
      end
    end
  end

  describe 'tree_metric_configurations' do
    context 'with at least 1 tree_metric configuration' do
      let!(:tree_metric_configuration) { FactoryGirl.build(:tree_metric_configuration_with_id, kalibro_configuration: kalibro_configuration) }
      let!(:tree_metric_configurations) { [tree_metric_configuration] }

      before :each do
        kalibro_configuration.expects(:tree_metric_configurations).returns(tree_metric_configurations)
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)

        get :tree_metric_configurations, id: kalibro_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return an array of tree_metric_configurations' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({ tree_metric_configurations: [tree_metric_configuration] }.to_json))
      end
    end

    context 'without tree metric configurations' do
      let!(:tree_metric_configurations) { [] }
      before :each do
        kalibro_configuration.expects(:tree_metric_configurations).returns(tree_metric_configurations)
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)

        get :tree_metric_configurations, id: kalibro_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return an empty array' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({ tree_metric_configurations: [] }.to_json))
      end
    end
  end

  describe 'destroy' do
    before :each do
      kalibro_configuration.expects(:destroy).returns(true)
      KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)

      delete :destroy, id: kalibro_configuration.id, format: :json
    end

    it { is_expected.to respond_with(:success) }
  end
end
