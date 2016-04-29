module Kolekti
  module Radon
    module Parser
      class Raw < Base
        def self.command
          'raw'
        end

        def self.default_value
          0.0
        end
      end
    end
  end
end
