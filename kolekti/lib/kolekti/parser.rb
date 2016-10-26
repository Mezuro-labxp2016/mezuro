module Kolekti
  class Parser
    def self.parse(collected_metrics_hash, metric_configuration, persistence_strategy); raise NotImplementedError; end

    # Sometimes the parser does not generate results for some Module that
    # other may generate. In this we case need a default value to fulfill
    # it.
    def self.default_value; raise NotImplementedError; end

    def self.parse_file_name(file_name)
      # Generates a module name by removing the file extension, replacing slashes with dots, and internal dots with underscores
      path = Pathname.new(file_name.to_s)

      path = (path.sub_ext '').to_s

      path.sub! /^\//, ''
      path.sub! /\/$/, ''
      path.gsub! '.', '_'
      path.gsub! '/', '.'

      path
    end
  end
end
