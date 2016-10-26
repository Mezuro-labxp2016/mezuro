module KalibroClient
  module Entities
    module Miscellaneous
      class DateModuleResult
        attr_accessor :date, :module_result

        def initialize(attributes={})
          @date = attributes[:date]
          @module_result = attributes[:module_result]
        end

        def result
          @module_result.grade
        end
      end
    end
  end
end
