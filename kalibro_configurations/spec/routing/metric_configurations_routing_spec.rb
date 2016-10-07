require 'rails_helper'

RSpec.describe MetricConfigurationsController do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/metric_configurations').to route_to('metric_configurations#create')
    end

    it 'routes to #update' do
      expect(put: '/metric_configurations/1').to route_to('metric_configurations#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/metric_configurations/1').to route_to('metric_configurations#destroy', id: '1')
    end

    it 'routes to #show' do
      expect(get: '/metric_configurations/1').to route_to('metric_configurations#show', id: '1')
    end

    it 'routes to #exists' do
      expect(get: '/metric_configurations/1/exists').to route_to('metric_configurations#exists', id: '1')
    end
  end
end
