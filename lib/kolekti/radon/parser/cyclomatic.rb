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

          pre_parse(cc_output).each do |module_name, result, granularity|
            module_name = module_name + '.' + result['name']
            value = result['complexity'].to_f
            persistence_strategy.create_tree_metric_result(
              metric_configuration, module_name, value, granularity)
          end
        end

        private

        # This method checks for errors found by Radon, switches the valid results between METHOD and FUNCTION
        # Returns an Enumerator of 3-element tuples of [module_name, result, granularity]
        def pre_parse(cc_output)
          Enumerator.new do |parsed_result|
            cc_output.each do |file_name, results|
              # If Radon couldn't parse the file we don't want to continue since the output is a error message
              next if has_error?(file_name, results)

              file_module_name = self.class.parse_file_name(file_name)
              results.each do |result|
                if result['type'] == 'class'
                  granularity = KalibroClient::Entities::Miscellaneous::Granularity::METHOD
                  class_name = result['name']

                  result['methods'].each do |method|
                    parsed_result << ["#{file_module_name}.#{class_name}", method, granularity]
                  end
                else
                  next if result['type'] == 'method' # These entries are duplicated on Radon's output
                  granularity = KalibroClient::Entities::Miscellaneous::Granularity::FUNCTION
                  parsed_result << [file_module_name, result, granularity]
                end
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
