require 'likeno'

module KalibroClient
  module KalibroCucumberHelpers
    class Cleaner
      include Likeno::RequestMethods

      attr_reader :address_key

      def initialize(address_key)
        @address_key = address_key
      end

      def address
        Likeno.config[address_key]
      end

      def endpoint
        'tests'
      end

      def clean_database
        request('clean_database', {}, :post)
      end
    end
  end
end
