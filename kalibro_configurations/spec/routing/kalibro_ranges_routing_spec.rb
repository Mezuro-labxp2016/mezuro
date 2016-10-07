require 'rails_helper'

RSpec.describe KalibroRangesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/metric_configurations/3/kalibro_ranges').to route_to('kalibro_ranges#index', metric_configuration_id: '3')
    end

    it 'routes to #show' do
      expect(get: '/kalibro_ranges/3').to route_to('kalibro_ranges#show', id: '3')
    end

    it 'routes to #exists' do
      expect(get: '/kalibro_ranges/3/exists').to route_to('kalibro_ranges#exists', id: '3')
    end

    it 'routes to #destroy' do
      expect(delete: '/metric_configurations/3/kalibro_ranges/1').to route_to('kalibro_ranges#destroy', metric_configuration_id: '3', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/metric_configurations/3/kalibro_ranges').to route_to('kalibro_ranges#create', metric_configuration_id: '3')
    end

    it 'routes to #update' do
      expect(put: '/metric_configurations/3/kalibro_ranges/1').to route_to('kalibro_ranges#update', metric_configuration_id: '3', id: '1')
    end
  end
end
