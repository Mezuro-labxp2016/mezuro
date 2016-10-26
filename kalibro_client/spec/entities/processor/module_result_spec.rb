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

describe KalibroClient::Entities::Processor::ModuleResult do
  subject { FactoryGirl.build(:module_result, id: rand(Time.now.to_i)) }

  describe 'children' do
    before :each do
      KalibroClient::Entities::Processor::ModuleResult.
        expects(:request).
        with(':id/children', {id: subject.id}, :get).
        returns({'module_results' => subject.to_hash})
    end

    it 'should return a list of objects' do
      expect(subject.children).to eq [subject]
    end
  end

  describe 'parents' do
    let(:root_module_result) { FactoryGirl.build(:root_module_result) }

    context 'when module result has a parent' do
      before :each do
        subject.class.expects(:find).with(subject.parent_id).returns(root_module_result)
      end

      it 'should return its parent' do
        expect(subject.parents).to eq [root_module_result]
      end
    end

    context 'when module result does not have a parent' do
      it 'should return an empty list' do
        expect(root_module_result.parents).to eq []
      end
    end
  end

  describe 'id=' do
    it 'should set the id attribute as integer' do
      subject.id = 23
      expect(subject.id).to eq 23
    end
  end

  describe 'kalibro_module' do
    let(:kalibro_module) { FactoryGirl.build(:kalibro_module) }

    before :each do
    end

    it 'is expected to request the kalibro_module' do
      KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).
          with(':id/kalibro_module', { id: subject.id }, :get).
          returns("kalibro_module" => kalibro_module.to_hash)
      expect(subject.kalibro_module).to eq(kalibro_module)
    end

    context 'when a previous request has already been made' do
      before :each do
        KalibroClient::Entities::Processor::ModuleResult.
            expects(:request).
            with(':id/kalibro_module', { id: subject.id }, :get).
            returns("kalibro_module" => kalibro_module.to_hash)

        subject.kalibro_module
      end

      it 'should not request the kalibro_module and return the cached one' do
        expect(subject.kalibro_module).to eq(kalibro_module)
      end
    end
  end

  describe 'grade=' do
    it 'should set the grade attribute as float' do
      subject.grade = 12.5
      expect(subject.grade).to eq 12.5
    end
  end

  describe 'parent_id=' do
    it 'should set the parent_id attribute as integer' do
      subject.parent_id = 73
      expect(subject.parent_id).to eq 73
    end
  end

  describe 'history_of' do
    let(:subject) { FactoryGirl.build(:module_result, kalibro_module: FactoryGirl.build(:kalibro_module_with_id)) }
    let(:repository) { FactoryGirl.build(:repository) }
    let(:date_module_result) { FactoryGirl.build(:date_module_result) }
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with(':id/module_result_history_of', {id: repository.id, kalibro_module_id: subject.kalibro_module.id}).
        returns({'date_module_results' => [[date_module_result.date, date_module_result.module_result.to_hash]]})
    end

    it 'should return a list of date_module_results' do
      date_module_results = KalibroClient::Entities::Processor::ModuleResult.history_of(subject, repository.id)
      expect(date_module_results.first.result).to eq date_module_result.result
    end
  end

  describe 'folder? & file?' do
    context 'when the module result has childrens' do
      subject { FactoryGirl.build(:root_module_result) }

      before :each do
        subject.expects(:children).twice.returns([FactoryGirl.build(:module_result)])
      end

      it 'should return true for folder? and false for file?' do
        expect(subject.folder?).to be_truthy
        expect(subject.file?).to be_falsey
      end
    end

    context 'when the module result has no childrens' do
      subject { FactoryGirl.build(:module_result) }

      before :each do
        subject.expects(:children).twice.returns([])
      end

      it 'should return true for folder? and false for file?' do
        expect(subject.folder?).to be_falsey
        expect(subject.file?).to be_truthy
      end
    end
  end

  describe 'tree_metric_results' do
    subject { FactoryGirl.build(:root_module_result) }
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration, :with_id) }
    let(:tree_metric_result_1) { FactoryGirl.build(:tree_metric_result, metric_configuration: metric_configuration) }
    let(:tree_metric_result_2) { FactoryGirl.build(:tree_metric_result, metric_configuration: metric_configuration) }

    context 'with tree metric results' do
      before :each do
        KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).
          with(':id/metric_results', {id: subject.id}, :get).
          returns({'tree_metric_results' => [tree_metric_result_1.to_hash, tree_metric_result_2.to_hash]})
      end

      it 'should return the tree metric results' do
        expect(subject.tree_metric_results).to eq([tree_metric_result_1, tree_metric_result_2])
      end
    end

    context 'without tree metric results' do
      before :each do
        KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).
          with(':id/metric_results', {id: subject.id}, :get).
          returns({'tree_metric_results' => []})
      end

      it 'should return an empty array' do
        expect(subject.tree_metric_results).to eq([])
      end
    end
  end

  describe 'hotspot_metric_results' do
    subject { FactoryGirl.build(:root_module_result) }
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }
    let(:hotspot_metric_result_1) { FactoryGirl.build(:hotspot_metric_result, metric_configuration: metric_configuration) }
    let(:hotspot_metric_result_2) { FactoryGirl.build(:hotspot_metric_result, metric_configuration: metric_configuration) }

    context 'with hotspot metric results' do
      before :each do
        KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).
          with(':id/hotspot_metric_results', {id: subject.id}, :get).
          returns({'hotspot_metric_results' => [hotspot_metric_result_1.to_hash, hotspot_metric_result_2.to_hash]})
      end

      it 'should return the hotspot metric results' do
        expect(subject.hotspot_metric_results).to eq([hotspot_metric_result_1, hotspot_metric_result_2])
      end
    end

    context 'without hotspot metric results' do
      before :each do
        KalibroClient::Entities::Processor::ModuleResult.
          expects(:request).
          with(':id/hotspot_metric_results', {id: subject.id}, :get).
          returns({'hotspot_metric_results' => []})
      end

      it 'should return an empty array' do
        expect(subject.hotspot_metric_results).to eq([])
      end
    end
  end

  describe 'processing' do
    let(:processing) { FactoryGirl.build(:processing) }

    it 'is expected to find the processing' do
      KalibroClient::Entities::Processor::Processing.expects(:find).with(subject.processing_id).returns(processing)

      expect(subject.processing).to eq(processing)
    end
  end
end
