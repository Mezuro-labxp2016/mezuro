require 'likeno/helpers/hash_converters'

module KalibroClient
  module Entities
    module Miscellaneous
      class Base
        def initialize(attributes={})
          attributes.each { |field, value| send("#{field}=", value) if self.class.valid?(field) }
        end

        include Likeno::HashConverters
        def to_hash(options={})
          hash = Hash.new
          excepts = options[:except].nil? ? [] : options[:except]

          fields.each do |field|
            hash = field_to_hash(field).merge(hash) if !excepts.include?(field)
          end

          hash
        end

        def self.to_object value
          value.kind_of?(Hash) ? new(value) : value
        end

        def ==(another)
          unless self.class == another.class
            return false
          end

          self.variable_names.each do |name|
            next if name == "created_at" or name == "updated_at"
            unless self.send("#{name}") == another.send("#{name}") then
              return false
            end
          end

          return true
        end

        protected

        def fields
          instance_variable_names.each.collect { |variable| variable.to_s.sub(/@/, '') }
        end

        def instance_variable_names
          instance_variables.map { |var| var.to_s }
        end

        def variable_names
          instance_variable_names.each.collect { |variable| variable.to_s.sub(/@/, '') }
        end

      end
    end
  end
end
