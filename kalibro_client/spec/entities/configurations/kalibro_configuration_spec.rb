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

describe KalibroClient::Entities::Configurations::KalibroConfiguration do
  describe 'id=' do
    it 'should set the value of the attribute id as an Integer' do
      subject.id = "42"
      expect(subject.id).to eq(42)
    end
  end

  describe 'metric_configurations' do
    context 'with no metric configurations' do
      before :each do
        KalibroClient::Entities::Configurations::KalibroConfiguration.
          expects(:request).
          with(':id/metric_configurations', {id: subject.id}, :get).
          returns({'metric_configurations' => []})
      end

      it 'is expected to return an empty array' do
        expect(subject.metric_configurations).to be_empty
      end
    end

    context 'with metric configurations' do
      let(:metric_configuration_1) { FactoryGirl.build(:metric_configuration, kalibro_configuration_id: subject.id) }
      let(:metric_configuration_2) { FactoryGirl.build(:metric_configuration, kalibro_configuration_id: subject.id) }
      before :each do
        KalibroClient::Entities::Configurations::KalibroConfiguration.
          expects(:request).
          with(':id/metric_configurations', {id: subject.id}, :get).
          returns({'metric_configurations' => [metric_configuration_1.to_hash, metric_configuration_2.to_hash]})
      end

      it 'is expected to return an array with the given metric configurations' do
        expect(subject.metric_configurations).to eq([metric_configuration_1, metric_configuration_2])
      end
    end
  end

  describe 'hotspot_metric_configurations' do
    context 'with no hotspot metric configurations' do
      before :each do
        KalibroClient::Entities::Configurations::KalibroConfiguration.
          expects(:request).
          with(':id/hotspot_metric_configurations', {id: subject.id}, :get).
          returns({'hotspot_metric_configurations' => []})
      end

      it 'is expected to return an empty array' do
        expect(subject.hotspot_metric_configurations).to be_empty
      end
    end

    context 'with hotspot metric configurations' do
      let(:metric_configuration_1) { FactoryGirl.build(:metric_configuration, kalibro_configuration_id: subject.id) }
      let(:metric_configuration_2) { FactoryGirl.build(:metric_configuration, kalibro_configuration_id: subject.id) }

      before :each do
        KalibroClient::Entities::Configurations::KalibroConfiguration.
          expects(:request).
          with(':id/hotspot_metric_configurations', {id: subject.id}, :get).
          returns({'hotspot_metric_configurations' => [metric_configuration_1.to_hash, metric_configuration_2.to_hash]})
      end

      it 'is expected to return an array with the hotspot metric configurations' do
        expect(subject.hotspot_metric_configurations).to eq([metric_configuration_1, metric_configuration_2])
      end
    end
  end

  describe 'tree_metric_configurations' do
    context 'with no tree metric configurations' do
      before :each do
        KalibroClient::Entities::Configurations::KalibroConfiguration.
          expects(:request).
          with(':id/tree_metric_configurations', {id: subject.id}, :get).
          returns({'tree_metric_configurations' => []})
      end

      it 'is expected to return an empty array' do
        expect(subject.tree_metric_configurations).to be_empty
      end
    end

    context 'with tree metric configurations' do
      let(:metric_configuration_1) { FactoryGirl.build(:metric_configuration, kalibro_configuration_id: subject.id) }
      let(:metric_configuration_2) { FactoryGirl.build(:metric_configuration, kalibro_configuration_id: subject.id) }

      before :each do
        KalibroClient::Entities::Configurations::KalibroConfiguration.
          expects(:request).
          with(':id/tree_metric_configurations', {id: subject.id}, :get).
          returns({'tree_metric_configurations' => [metric_configuration_1.to_hash, metric_configuration_2.to_hash]})
      end

      it 'is expected to return an array with the tree metric configurations' do
        expect(subject.tree_metric_configurations).to eq([metric_configuration_1, metric_configuration_2])
      end
    end
  end
end
