Rails.application.routes.draw do

  get 'statistics/metric_percentage' => 'statistics#metric_percentage'

  resources :metric_snapshots, only: [:index, :show]
  get 'metric_snapshots/:id/metric_configuration' => 'metric_snapshots#metric_configuration'

  # Acceptance tests route
  post 'tests/clean_database' => 'tests#clean_database' unless Rails.env == "production"

  get 'kalibro_ranges/:id/exists' => 'kalibro_ranges#exists'
  get 'kalibro_ranges/:id' => 'kalibro_ranges#show'

  resources :metric_configurations, except: [:index, :new, :edit] do
    resources :kalibro_ranges, except: [:show, :new, :edit]
  end
  get 'metric_configurations/:id/exists' => 'metric_configurations#exists'

  # Routes for Kalibro Configuration
  resources :kalibro_configurations, except: [:index, :new, :edit]
  get 'kalibro_configurations' => 'kalibro_configurations#all'
  get 'kalibro_configurations/:id/exists' => 'kalibro_configurations#exists'
  get 'kalibro_configurations/:id/metric_configurations' => 'kalibro_configurations#metric_configurations'
  get 'kalibro_configurations/:id/hotspot_metric_configurations' => 'kalibro_configurations#hotspot_metric_configurations'
  get 'kalibro_configurations/:id/tree_metric_configurations' => 'kalibro_configurations#tree_metric_configurations'

  get 'readings/:id' => 'readings#show'
  get 'readings/:id/exists' => 'readings#exists'
  resources :reading_groups, except: [:index, :new, :edit] do
    resources :readings, except: [:new, :edit, :show]
  end
  get 'reading_groups' => 'reading_groups#all'
  get 'reading_groups/:id/exists' => 'reading_groups#exists'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root 'information#data'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
