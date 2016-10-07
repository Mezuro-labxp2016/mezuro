require 'rails_helper'

RSpec.describe ReadingGroupsController do
  describe 'routing' do
    it 'routes to #all' do
      expect(get: '/reading_groups').to route_to('reading_groups#all')
    end

    it 'routes to #exists' do
      expect(get: '/reading_groups/1/exists').to route_to('reading_groups#exists', id: '1')
    end

    it 'routes to #show' do
      expect(get: '/reading_groups/1').to route_to('reading_groups#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/reading_groups').to route_to('reading_groups#create')
    end

    it 'routes to #update' do
      expect(put: '/reading_groups/1').to route_to('reading_groups#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/reading_groups/1').to route_to('reading_groups#destroy', id: '1')
    end
  end
end
