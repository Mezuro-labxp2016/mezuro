require 'likeno/helpers/date_attributes'

module KalibroClient
  module Entities
    module Configurations
      class Base < KalibroClient::Entities::Base
        include Likeno::DateAttributes

        def self.address
          Likeno.config[:configurations_address]
        end
      end
    end
  end
end

