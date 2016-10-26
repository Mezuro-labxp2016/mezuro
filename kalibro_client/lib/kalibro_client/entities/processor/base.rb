require 'json'
require 'likeno/helpers/date_attributes'

module KalibroClient
  module Entities
    module Processor
      class Base < KalibroClient::Entities::Base
        include Likeno::DateAttributes

        def self.address
          Likeno.config[:processor_address]
        end
      end
    end
  end
end

