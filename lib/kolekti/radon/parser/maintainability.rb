module Kolekti
  module Radon
    module Parser
      class Maintainability < Base
        def command
          'mi'
        end

        def default_value
          100.0
        end
      end
    end
  end
end
