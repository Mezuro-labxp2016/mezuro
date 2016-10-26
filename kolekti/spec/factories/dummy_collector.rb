class DummyCollector < Kolekti::Collector
  def initialize
    mc = FactoryGirl.build(:metric_configuration)
    super(mc.metric.metric_collector_name, 'description', { mc.metric.code.to_sym => mc.metric })
  end

  def self.available?
    true
  end
end
