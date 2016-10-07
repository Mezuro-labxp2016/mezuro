require 'rails_helper'

RSpec.describe KalibroConfigurationsController do
  describe 'routing' do
    it 'routes to #all' do
      expect(get: '/kalibro_configurations').to route_to('kalibro_configurations#all')
    end

    it 'routes to #exists' do
      expect(get: '/kalibro_configurations/1/exists').to route_to('kalibro_configurations#exists', id: '1')
    end

    it 'routes to #metric_configurations' do
      expect(get: '/kalibro_configurations/1/metric_configurations').to route_to('kalibro_configurations#metric_configurations', id: '1')
    end

    it 'routes to #hotspot_metric_configurations' do
      expect(get: '/kalibro_configurations/1/hotspot_metric_configurations').to route_to('kalibro_configurations#hotspot_metric_configurations', id: '1')
    end

    it 'routes to #tree_metric_configurations' do
      expect(get: '/kalibro_configurations/1/tree_metric_configurations').to route_to('kalibro_configurations#tree_metric_configurations', id: '1')
    end

    it 'routes to #show' do
      expect(get: '/kalibro_configurations/1').to route_to('kalibro_configurations#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/kalibro_configurations').to route_to('kalibro_configurations#create')
    end

    it 'routes to #update' do
      expect(put: '/kalibro_configurations/1').to route_to('kalibro_configurations#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/kalibro_configurations/1').to route_to('kalibro_configurations#destroy', id: '1')
    end
  end
end
