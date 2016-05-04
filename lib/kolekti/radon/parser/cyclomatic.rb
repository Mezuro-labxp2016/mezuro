require 'logger'

module Kolekti
  module Radon
    module Parser
      class Cyclomatic < Base
        def self.default_value
          1.0
        end

        def command
          'cc'
        end

        def parse(cc_output)
          metric_configuration = metric_configurations.first

          parse_output(cc_output) do |module_name, result, granularity|
            value = result['complexity'].to_f
            persistence_strategy.create_tree_metric_result(
              metric_configuration, module_name, value, granularity)
          end
        end

        private

        # This method checks for errors found by Radon, switches the valid results between METHOD and FUNCTION
        # Calls the passed block multiple times with (module_name, result, granularity)
        def parse_output(cc_output, &block)
          cc_output.each do |file_name, entries|
            # If Radon couldn't parse the file we don't want to continue since the output is a error message
            next if has_error?(file_name, entries)

            file_module_name = self.class.parse_file_name(file_name)
            functions = []
            classes = []

            entries.each do |entry|
              if entry['type'] == 'class'
                classes << entry
              elsif entry['type'] == 'method'
                # These entries are duplicated on Radon's output
                next
              else
                functions << entry
              end
            end

            parse_entries(functions, file_module_name,
                          KalibroClient::Entities::Miscellaneous::Granularity::FUNCTION, &block)

            parse_entries(classes, file_module_name) do |class_module_name, class_entry, _|
              parse_entries(class_entry['methods'], class_module_name,
                            KalibroClient::Entities::Miscellaneous::Granularity::METHOD, &block)
            end
          end
        end

        def parse_entries(entries, base_module_name, granularity=nil)
          # It's possible for multiple methods to be declared with the same name,
          # even though they'll never be assigned to the same slots at runtime, such
          # as when declaring properties in classes.
          # Radon will produce the same name in those cases, so deal with them by
          # appending the line number to any methods with the same module name
          entries.group_by { |entry| entry['name'] }.each do |name, module_entries|
            if module_entries.size == 1
              module_name = "#{base_module_name}.#{name}"
              yield module_name, module_entries.first, granularity
            else
              module_entries.each do |entry|
                module_name = "#{base_module_name}.#{name}:#{entry['lineno']}"
                yield module_name, entry, granularity
              end
            end
          end
        end

        def has_error?(file_name, results)
          if results.is_a?(Array)
            false
          else
            error = results['error'] if results.is_a?(Hash)
            error ||= 'Unknown error'

            # This debug print has been kept in order that if there is some non-fatal error it does not get ignored
            logger.debug("error parsing file #{file_name}: #{error}")

            true
          end
        end
      end
    end
  end
end
