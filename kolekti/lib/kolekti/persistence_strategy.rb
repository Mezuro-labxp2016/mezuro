module Kolekti
  class PersistenceStrategy
    def create_tree_metric_result(metric_configuration, module_name, value, granularity)
      raise NotImplementedError
    end

    def create_hotspot_metric_result(metric_configuration, module_name, line, message)
      raise NotImplementedError
    end

    def create_related_hotspot_metric_results(metric_configuration, results)
      raise NotImplementedError
    end
  end
end
