module Kolekti
  module Radon
    module Parser
      class Raw < Base
        def command
          'raw'
        end

        def default_value
          0.0
        end
      end
    end
  end
end
