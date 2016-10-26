module Kolekti
  module Radon
    module Parser
      class Raw < Base
        def self.default_value
          0.0
        end

        def command
          'raw'
        end
      end
    end
  end
end
