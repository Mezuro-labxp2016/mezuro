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

describe KalibroClient::Entities::Processor::TreeMetricResult do
  let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }

  before do
    KalibroClient::Entities::Configurations::MetricConfiguration.
      stubs(:request).
      with(':id', {id: metric_configuration.id}, :get).
      returns({'metric_configuration' => metric_configuration.to_hash})
  end

  describe 'new' do
    before :each do
      subject.metric_configuration_id = metric_configuration.id
    end
    context 'with value NaN' do
      it 'should set the value with aggregated_value' do
        attributes_hash = FactoryGirl.build(:tree_metric_result, {"aggregated_value" => 1.6}).to_hash
        attributes_hash["value"] = "NaN"
        metric_result = KalibroClient::Entities::Processor::TreeMetricResult.new(attributes_hash)
        expect(metric_result.value).to eq(1.6)
      end
    end
  end

  describe 'aggregated_value=' do
    it 'should set the value of the attribute aggregated_value' do
      subject.aggregated_value = 42
      expect(subject.aggregated_value).to eq(42)
    end
  end

  describe 'descendant_values' do
    context 'when there is one descendant value for the given metric_result' do
      before :each do
        KalibroClient::Entities::Processor::TreeMetricResult.
        expects(:request).
        with(':id/descendant_values', { id: subject.id }, :get).
        returns({'descendant_values' => [13.3]})
      end

      it 'should return an unitary list with the descendant value' do
        expect(subject.descendant_values).to eq([13.3])
      end
    end

    context 'when there is no descendant value for the given metric_result' do
      before :each do
        KalibroClient::Entities::Processor::TreeMetricResult.
        expects(:request).
        with(':id/descendant_values', { id: subject.id }, :get).
        returns({'descendant_values' => []})
      end

      it 'should return an empty list' do
        expect(subject.descendant_values).to eq([])
      end
    end
  end

  describe 'history_of' do
    let(:kalibro_module) { FactoryGirl.build(:kalibro_module_with_id) }
    let(:metric) { FactoryGirl.build(:metric) }
    let(:repository) { FactoryGirl.build(:repository_with_id) }

    context 'when there is not a date metric result' do
      before :each do
        KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with(':id/metric_result_history_of', {:metric_name => metric.name, :kalibro_module_id => kalibro_module.id, id: repository.id}).
        returns({'metric_result_history_of' => []})
      end

      it 'should return an empty list' do
        expect(KalibroClient::Entities::Processor::TreeMetricResult.history_of(metric.name, kalibro_module.id, repository.id)).to eq([])
      end
    end

    context 'when there is only one date metric result' do
      let!(:date_metric_result) { FactoryGirl.build(:date_metric_result, metric_result: subject.to_hash) }

      before :each do
        KalibroClient::Entities::Processor::Repository.
        expects(:request).with(':id/metric_result_history_of', {:metric_name => metric.name, :kalibro_module_id => kalibro_module.id, id: repository.id})
        .returns({'metric_result_history_of' => [date_metric_result.to_hash]})
      end

      it 'should return the date metric result as an object into a list' do
        expect(KalibroClient::Entities::Processor::TreeMetricResult.history_of(metric.name, kalibro_module.id, repository.id).first.metric_result.id).to eq(subject.id)
      end
    end

    context 'when there are many date metric results' do
      let(:date_metric_result) { FactoryGirl.build(:date_metric_result, {metric_result: subject.to_hash}) }
      let(:another_date_metric_result) { FactoryGirl.build(:another_date_metric_result, {metric_result: subject.to_hash}) }

      before :each do
        KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with(':id/metric_result_history_of', {:metric_name => metric.name, :kalibro_module_id => kalibro_module.id, id: repository.id}).
        returns({'metric_result_history_of' => [date_metric_result.to_hash, another_date_metric_result.to_hash]})
      end

      it 'should return a list of date metric results as objects' do
        response = KalibroClient::Entities::Processor::TreeMetricResult.history_of(metric.name, kalibro_module.id, repository.id)
        expect(response.first.metric_result.id).to eq(date_metric_result.metric_result.id)
        expect(response.last.metric_result.id).to eq(another_date_metric_result.metric_result.id)
      end
    end
  end
end