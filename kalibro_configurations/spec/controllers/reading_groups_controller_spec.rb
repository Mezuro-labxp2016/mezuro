require 'rails_helper'

RSpec.describe ReadingGroupsController do
  let!(:reading_group) { FactoryGirl.build(:reading_group) }

  describe 'exists' do
    context 'when the reading_group exists' do
      before :each do
        ReadingGroup.expects(:exists?).with(reading_group.id).returns(true)

        get :exists, id: reading_group.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'should return true' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({exists: true}.to_json))
      end
    end

    context 'when the reading_group does not exist' do
      before :each do
        ReadingGroup.expects(:exists?).with(reading_group.id).returns(false)

        get :exists, id: reading_group.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'should return the error description with the reading_group' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({exists: false}.to_json))
      end
    end
  end

  describe 'all' do
    let!(:reading_groups) { [reading_group] }

    before :each do
      ReadingGroup.expects(:all).returns(reading_groups)

      get :all, format: :json
    end

    it { is_expected.to respond_with(:success) }

    it 'is expected to return the list of reading_groups converted to JSON' do
      expect(JSON.parse(response.body)).to eq(JSON.parse({reading_groups: reading_groups}.to_json))
    end
  end

  describe 'show' do
    context 'when the ReadingGroup exists' do
      before :each do
        ReadingGroup.expects(:find).with(reading_group.id).returns(reading_group)

        get :show, id: reading_group.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return the list of reading_groups converted to JSON' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({reading_group: reading_group}.to_json))
      end
    end

    context 'when the ReadingGroup does not exist' do
      before :each do
        ReadingGroup.expects(:find).with(reading_group.id).raises(ActiveRecord::RecordNotFound)

        get :show, id: reading_group.id, format: :json
      end

      it { is_expected.to respond_with(:not_found) }

      it 'should return the error description' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({errors: ['ActiveRecord::RecordNotFound']}.to_json))
      end
    end
  end

  describe 'create' do
    let(:reading_group_params) { FactoryGirl.attributes_for(:reading_group).stringify_keys }

    context 'with valid attributes' do
      before :each do
        ReadingGroup.any_instance.expects(:save).returns(true)

        post :create, reading_group: reading_group_params, format: :json
      end

      it { is_expected.to respond_with(:created) }

      it 'is expected to return the reading_group' do
        reading_group.id = nil
        expect(JSON.parse(response.body)).to eq(JSON.parse({reading_group: reading_group}.to_json))
      end
    end

    context 'with invalid attributes' do
      before :each do
        ReadingGroup.any_instance.expects(:save).returns(false)

        post :create, reading_group: reading_group_params, format: :json
      end

      it { is_expected.to respond_with(:unprocessable_entity) }

      it 'should return the error description' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({errors: []}.to_json))
      end
    end
  end

  describe 'update' do
    let(:reading_group_params) { FactoryGirl.attributes_for(:reading_group).stringify_keys }

    before :each do
      ReadingGroup.expects(:find).with(reading_group.id).returns(reading_group)
    end

    context 'with valid attributes' do
      before :each do
        reading_group_params.delete('id')
        ReadingGroup.any_instance.expects(:update).with(reading_group_params).returns(true)

        put :update, reading_group: reading_group_params, id: reading_group.id, format: :json
      end

      it { is_expected.to respond_with(:created) }

      it 'is expected to return the reading_group' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({reading_group: reading_group}.to_json))
      end
    end

    context 'with invalid attributes' do
      before :each do
        reading_group_params.delete('id')
        ReadingGroup.any_instance.expects(:update).with(reading_group_params).returns(false)

        put :update, reading_group: reading_group_params, id: reading_group.id, format: :json
      end

      it { is_expected.to respond_with(:unprocessable_entity) }

      it 'should return the error description' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({errors: []}.to_json))
      end
    end
  end

  describe 'destroy' do
    before :each do
      reading_group.expects(:destroy).returns(true)
      ReadingGroup.expects(:find).with(reading_group.id).returns(reading_group)

      delete :destroy, id: reading_group.id, format: :json
    end

    it { is_expected.to respond_with(:success) }
  end
end
