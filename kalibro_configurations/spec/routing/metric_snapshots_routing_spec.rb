require 'rails_helper'

RSpec.describe MetricSnapshotsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/metric_snapshots').to route_to('metric_snapshots#index')
    end

    it 'routes to #new' do
      expect(get: '/metric_snapshots/new').to_not route_to('metric_snapshots#new')
    end

    it 'routes to #show' do
      expect(get: '/metric_snapshots/1').to route_to('metric_snapshots#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/metric_snapshots/1/edit').to_not route_to('metric_snapshots#edit', id: '1')
    end

    it 'routes to #metric_configuration' do
      expect(get: '/metric_snapshots/1/metric_configuration').to route_to('metric_snapshots#metric_configuration', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/metric_snapshots').to_not route_to('metric_snapshots#create')
    end

    it 'routes to #update' do
      expect(put: '/metric_snapshots/1').to_not route_to('metric_snapshots#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/metric_snapshots/1').to_not route_to('metric_snapshots#destroy', id: '1')
    end
  end
end
