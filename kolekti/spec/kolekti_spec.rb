require 'spec_helper'

describe Kolekti do
  let(:collector) { DummyCollector }

  it 'has a version number' do
    expect(Kolekti::VERSION).not_to be nil
  end

  describe 'methods' do
    context 'altering collectors state' do
      before :each do
        Kolekti.register_collector(collector)
      end

      after :each do
        Kolekti.deregister_collector(collector)
      end

      describe 'register_collector' do
        it 'is expected to add a collector to the list' do
          expect(Kolekti::COLLECTORS).to include(collector)
        end
      end

      describe 'collectors' do
        it 'is expected to return the current collectors' do
          expect(Kolekti.collectors).to include(collector)
        end
      end
    end

    context 'registration' do
      context 'when the collector is not available' do
        before :each do
          collector.expects(:available?).returns(false)
        end

        it 'is expected that the collectors list to not include the collector' do
          Kolekti.register_collector(collector)
          expect(Kolekti::COLLECTORS).to_not include(collector)
        end
      end

      context 'when trying to register an already registered collector' do
        before :each do
          Kolekti.register_collector(collector)
        end

        it 'is expected to have only one entry for collector' do
          expect(Kolekti::COLLECTORS.size).to eq(1)
        end

        after :each do
          Kolekti.deregister_collector(collector)
        end
      end
    end

    describe 'deregister_collector' do
      context 'with an unregistered collector' do
        it 'is expected to raise an ArgumentError' do
          expect { Kolekti.deregister_collector(collector) }.to raise_error(ArgumentError)
        end
      end

      context 'with a registered collector' do
        before do
          Kolekti.register_collector(collector)
        end
        it 'is expected to remove the collector from the list' do
          Kolekti.deregister_collector(collector)
          expect(Kolekti::COLLECTORS).to_not include collector
        end
      end
    end

    describe 'default_metric_value' do
      let(:metric) { FactoryGirl.build(:native_metric) }
      let(:metric_configuration) { FactoryGirl.build(:metric_configuration, metric: metric) }

      context 'with an existing collector' do
        let(:value) { 1337 }

        before :each do
          collector.expects(:name).returns(metric_configuration.metric.metric_collector_name)
          Kolekti.expects(:collectors).returns([collector])
        end

        it "is expected to get the metric's collector default value" do
          collector.expects(:default_value_from).with(metric_configuration).returns(value)

          expect(Kolekti.default_metric_value(metric_configuration)).to eq(value)
        end
      end

      context 'without an existing collector' do
        before :each do
          Kolekti.expects(:collectors).returns([])
        end

        it 'is expected to return nil' do
          expect(Kolekti.default_metric_value(metric_configuration)).to be_nil
        end
      end
    end
  end
end
