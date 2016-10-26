module KalibroClient
  module Entities
    module Miscellaneous
      class Granularity < KalibroClient::Entities::Miscellaneous::Base
        include Comparable

        GRANULARITIES = [:METHOD, :CLASS, :PACKAGE, :SOFTWARE, :FUNCTION]

        GRANULARITIES.each do |name|
          self.const_set(name, name)
        end

        PARENTS = {
            METHOD: CLASS,
            CLASS: PACKAGE,
            PACKAGE: SOFTWARE,
            SOFTWARE: SOFTWARE,
            FUNCTION: PACKAGE
        }

        attr_reader :type

        def initialize(type)
          type = type.to_sym
          if GRANULARITIES.include?(type)
            @type = type
          else
            raise TypeError.new("Not supported granularity type #{type}")
          end
        end

        def parent
          parent_type = PARENTS[self.type]
          raise ArgumentError.new("Not supported granularity type #{type}") if parent_type.nil?

          return self if self.type == parent_type
          Granularity.new(parent_type)
        end

        def to_s
          self.type.to_s
        end

        # FYI: this is a spaceship operator
        def <=>(other)
          return nil if [[:FUNCTION, :METHOD], [:METHOD, :FUNCTION], [:FUNCTION, :CLASS], [:CLASS, :FUNCTION]].include?([self.type, other.type])

          if self.type == other.type
            return 0
          elsif self.is_lower_than?(other.type)
            return -1
          else
            return 1
          end
        end

        def is_lower_than?(other_type)
          current_type = self.type

          while current_type != PARENTS[current_type]
            return true if PARENTS[current_type] == other_type
            current_type = PARENTS[current_type]
          end

          return false
        end
      end
    end
  end
end
