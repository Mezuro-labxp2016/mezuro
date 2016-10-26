module Kolekti
  class KolektiError < RuntimeError; end

  class UnavailableMetricError < KolektiError; end
  class CollectorError < KolektiError; end
end
