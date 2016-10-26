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

describe KalibroClient::Entities::Processor::MetricResult do
  let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
  subject { FactoryGirl.build(:metric_result) }

  before do
    KalibroClient::Entities::Configurations::MetricConfiguration.
      stubs(:request).
      with(':id', {id: metric_configuration.id}, :get).
      returns({'metric_configuration' => metric_configuration.to_hash})
  end

  describe 'id=' do
    it 'should set the value of the attribute id' do
      subject.id = 42
      expect(subject.id).to eq(42)
    end
  end

  describe 'metric_configuration=' do
    it 'should set the metric configuration' do
      subject.metric_configuration = metric_configuration
      expect(subject.metric_configuration.weight).to eq(metric_configuration.weight)
      expect(subject.metric_configuration.aggregation_form).to eq(metric_configuration.aggregation_form)
      expect(subject.metric_configuration.reading_group_id).to eq(metric_configuration.reading_group_id)
      expect(subject.metric_configuration.kalibro_configuration_id).to eq(metric_configuration.kalibro_configuration_id)
      expect(subject.metric_configuration_id).to eq(metric_configuration.id)
    end
  end

  describe 'metric_configuration' do
    context 'when metric_configuration_id is nil' do
      before :each do
        subject.metric_configuration_id = nil
      end

      it 'is expected to return nil' do
        expect(subject.metric_configuration).to be_nil
      end
    end

    context 'when metric_configuration_id is not nil' do
      subject { FactoryGirl.build(:metric_result,
                                  metric_configuration: nil,
                                  metric_configuration_id: metric_configuration.id) }

      context 'and it has already been memoized' do
        before :each do
          subject.metric_configuration = metric_configuration
        end

        it 'is expected to return the memoized instance' do
          expect(subject.metric_configuration).to eq(metric_configuration)
        end
      end

      context 'and it has not been memoized' do
        before do
          subject.metric_configuration_id = metric_configuration.id
        end

        it 'is expected to find the metric configuration from its id' do
          KalibroClient::Entities::Configurations::MetricConfiguration.expects(:find).
            with(subject.metric_configuration_id).
            returns(metric_configuration)

          expect(subject.metric_configuration).to eq(metric_configuration)
        end
      end
    end
  end

  describe 'value=' do
    it 'should set the value of the attribute value' do
      subject.value = 42
      expect(subject.value).to eq(42)
    end
  end

  describe 'module_result' do
    let(:module_result) { FactoryGirl.build(:module_result, :with_id) }
    subject { FactoryGirl.build(:metric_result, module_result_id: module_result.id) }

    context 'when module_result is nil' do
      before do
        described_class.expects(:request).with(':id/module_result', { id: subject.id }, :get)
          .returns('module_result' => module_result.to_hash)
      end

      it 'is expected to request the module result and set it' do
        expect(subject.module_result).to eq(module_result)
      end
    end

    context 'when the module_result_id is different than the module_result\'s id' do
      let(:different_id) { module_result.id + 1 }
      let(:different_module_result) { FactoryGirl.build(:module_result, id: different_id) }

      before do
        described_class.expects(:request).with(':id/module_result', { id: subject.id }, :get)
          .returns('module_result' => different_module_result.to_hash)
      end

      it 'is expected to set the module_result to the one matched by the id' do
        subject.module_result_id = different_module_result.id
        expect(subject.module_result).to eq(different_module_result)
      end
    end

    context 'when the module_result_id is the same as the module_result\'s id' do
      before do
        described_class.expects(:request).with(':id/module_result', { id: subject.id }, :get)
          .once.returns('module_result' => module_result.to_hash)
      end

      it 'is expected to not change the module_result' do
        expect(subject.module_result).to eq(module_result)
      end
    end
  end
end
