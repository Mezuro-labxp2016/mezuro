module KalibroClient
  module Entities
    module Configurations
      class Statistic < KalibroClient::Entities::Configurations::Base
        def self.metric_percentage(metric_code)
          request('/metric_percentage', {metric_code: metric_code}, :get)
        end
      end
    end
  end
end
