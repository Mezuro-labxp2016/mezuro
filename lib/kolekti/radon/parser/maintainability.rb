module Kolekti
  module Radon
    module Parser
      class Maintainability < Base
        def self.default_value
          100.0
        end

        def command
          'mi'
        end
      end
    end
  end
end
