# This file is part of KalibroClient
# Copyright (C) 2013  it's respectives authors (please see the AUTHORS file)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'spec_helper'

describe KalibroClient::Entities::Configurations::MetricConfiguration do
  describe 'id=' do
    it 'should set the id as an Integer' do
      subject.id = "42"
      expect(subject.id).to eq(42)
    end
  end

  describe 'reading_group_id=' do
    it 'should set the reading group id' do
      subject.reading_group_id = "1"
      expect(subject.reading_group_id).to eq(1)
    end
  end

  describe 'metric=' do
    context 'with a Hash' do
      context 'NativeMetric' do
        let!(:metric) { FactoryGirl.build(:loc) }

        before :each do
          KalibroClient::Entities::Miscellaneous::NativeMetric.
          expects(:to_object).at_least_once.
          with(metric.to_hash).
          returns(metric)
        end

        it 'should convert the argument and set the metric' do
          subject.metric = metric.to_hash
          expect(subject.metric).to eq(metric)
        end
      end

      context 'CompoundMetric' do
        let!(:metric) { FactoryGirl.build(:compound_metric) }

        before :each do
          KalibroClient::Entities::Miscellaneous::CompoundMetric.
          expects(:to_object).at_least_once.
          with(metric.to_hash).
          returns(metric)
        end

        it 'should convert the argument and set the metric' do
          subject.metric = metric.to_hash
          expect(subject.metric).to eq(metric)
        end
      end

      context 'HotspotMetric' do
        let!(:metric) { FactoryGirl.build(:hotspot_metric) }

        before :each do
          KalibroClient::Entities::Miscellaneous::HotspotMetric.
          expects(:to_object).at_least_once.
          with(metric.to_hash).
          returns(metric)
        end

        it 'should convert the argument and set the metric' do
          subject.metric = metric.to_hash
          expect(subject.metric).to eq(metric)
        end
      end
    end

    context 'with a Metric' do
      let!(:metric) { FactoryGirl.build(:metric) }

      it 'should convert the argument and set the metric' do
        subject.metric = metric
        expect(subject.metric).to eq(metric)
      end
    end

    context 'with something else' do
      let!(:repository) { FactoryGirl.build(:repository) }

      it 'should convert the argument and set the metric' do
        expect { subject.metric=(repository) }.to raise_error(TypeError).with_message("Cannot cast #{repository.inspect} into Metric")
      end
    end
  end

  describe 'weight=' do
    it 'should set the weight' do
      subject.weight = "10"
      expect(subject.weight).to eq(10)
    end
  end

  describe 'update_attributes' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }

    before :each do
      KalibroClient::Entities::Configurations::MetricConfiguration.any_instance.
      expects(:save).
      returns(true)
    end

    it 'should set the attributes and save' do
      subject.update_attributes(metric_configuration.to_hash)
      expect(subject.weight).to eq(metric_configuration.weight)
      expect(subject.aggregation_form).to eq(metric_configuration.aggregation_form)
      expect(subject.reading_group_id).to eq(metric_configuration.reading_group_id)
      expect(subject.kalibro_configuration_id).to eq(metric_configuration.kalibro_configuration_id)
    end
  end

  describe 'to_hash' do
    subject {FactoryGirl.build(:metric_configuration_with_id)}

    it 'should not include the configuration_id' do
      expect(subject.to_hash[:kalibro_configuration_id]).to be_nil
    end
  end

  describe 'metric_configurations_of' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
    let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration_with_id) }

    before :each do
      KalibroClient::Entities::Configurations::MetricConfiguration.
      expects(:request).
      with('', {}, :get, "kalibro_configurations/#{kalibro_configuration.id}").
      returns({'metric_configurations' => [metric_configuration.to_hash]})
    end

    it 'should return a array with a metric configuration' do
      metric_configurations = KalibroClient::Entities::Configurations::MetricConfiguration.metric_configurations_of(kalibro_configuration.id)

      expect(metric_configurations).to be_an(Array)
      expect(metric_configurations.first.id).to eq(metric_configuration.id)
    end
  end

  # The only purpose of this test is to cover the overrided save_params method
  describe 'save' do
    subject {FactoryGirl.build(:metric_configuration)}

    before :each do
      KalibroClient::Entities::Configurations::MetricConfiguration.
      expects(:request).
      with('', {:metric_configuration => subject.to_hash, :kalibro_configuration_id => subject.kalibro_configuration_id}, :post, '', {}).
      returns("metric_configuration" => {'id' => 1, 'kalibro_errors' => []})
    end

    it 'should make a request to save model with id and return true without errors' do
      expect(subject.save).to be_truthy
      expect(subject.kalibro_errors).to be_empty
    end
  end

  describe 'kalibro ranges' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
    let(:kalibro_range_1) { FactoryGirl.build(:range, metric_configuration_id: metric_configuration.id) }
    let(:kalibro_range_2) { FactoryGirl.build(:range, metric_configuration_id: metric_configuration.id) }

    before :each do
      KalibroClient::Entities::Configurations::MetricConfiguration.
      expects(:request).
      with(':id/kalibro_ranges', {id: metric_configuration.id}, :get).
      returns({'kalibro_ranges' => [kalibro_range_1.to_hash, kalibro_range_2.to_hash]})
    end

    it 'should return the kalibro ranges of a metric configuration' do
      expect(metric_configuration.kalibro_ranges).to eq([kalibro_range_1, kalibro_range_2])
    end
  end
end
