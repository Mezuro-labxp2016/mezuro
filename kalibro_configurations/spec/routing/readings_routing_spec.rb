require 'rails_helper'

RSpec.describe ReadingsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'reading_groups/1/readings').to route_to('readings#index', reading_group_id: '1')
    end

    it 'routes to #exists' do
      expect(get: 'readings/1/exists').to route_to('readings#exists', id: '1')
    end

    it 'routes to #show' do
      expect(get: 'readings/1').to route_to('readings#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: 'reading_groups/1/readings').to route_to('readings#create', reading_group_id: '1')
    end

    it 'routes to #update' do
      expect(put: 'reading_groups/1/readings/1').to route_to('readings#update', reading_group_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'reading_groups/1/readings/1').to route_to('readings#destroy', reading_group_id: '1', id: '1')
    end
  end
end
