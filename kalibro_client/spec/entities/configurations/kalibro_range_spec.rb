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

describe KalibroClient::Entities::Configurations::KalibroRange do
  subject { FactoryGirl.build(:range_with_id) }

  describe 'id=' do
    it 'should set the value of the attribute id as an integer' do
      subject.id = "4"
      expect(subject.id).to eq(4)
    end
  end

  describe 'reading_id=' do
    it 'should set the value of the attribute reading_id as an integer' do
      subject.reading_id = "12"
      expect(subject.reading_id).to eq(12)
    end
  end

  describe 'getting reading attribute' do
    let(:reading) { FactoryGirl.build(:reading_with_id) }

    before :each do
      KalibroClient::Entities::Configurations::Reading.
        expects(:find).
        with(subject.reading_id).
        returns(reading)
    end

    context 'reading' do
      it 'should return the correct reading' do
        expect(subject.reading).to eq(reading)
      end
    end

    context 'label' do
      it 'should get the label of the reading' do
        expect(subject.label).to eq(reading.label)
      end
    end

    context 'grade' do
      it 'should get the grade of the reading' do
        expect(subject.grade).to eq(reading.grade)
      end
    end

    context 'color' do
      it 'should get the color of the reading' do
        expect(subject.color).to eq(reading.color)
      end
    end
  end

  describe 'ranges_of' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }

    context 'when does not exists the asked range' do
      before :each do
        KalibroClient::Entities::Configurations::KalibroRange.
          expects(:request).
          with('', {}, :get, "metric_configurations/#{metric_configuration.id}").
          returns({'ranges' => []})
      end

      it 'should return a list with the ranges' do
        expect(KalibroClient::Entities::Configurations::KalibroRange.ranges_of(metric_configuration.id)).to eq([])
      end
    end

    context 'when exist only one range for the given metric configuration' do
      before :each do
        KalibroClient::Entities::Configurations::KalibroRange.
          expects(:request).
          with('', {}, :get, "metric_configurations/#{metric_configuration.id}").
          returns({'kalibro_ranges' => subject.to_hash})
      end

      it 'should return a list with the range' do
        expect(KalibroClient::Entities::Configurations::KalibroRange.ranges_of(metric_configuration.id).
          first.beginning).to eq(subject.beginning)
      end
    end

    context 'when exists many ranges for the given metric configuration' do
      let(:another_range) { FactoryGirl.build(:another_range) }

      before :each do
        KalibroClient::Entities::Configurations::KalibroRange.
          expects(:request).
          with('', {}, :get, "metric_configurations/#{metric_configuration.id}").
          returns({'kalibro_ranges' => [subject.to_hash, another_range.to_hash]})
      end

      it 'should return a list with the ranges' do
        ranges = KalibroClient::Entities::Configurations::KalibroRange.ranges_of(metric_configuration.id)
        expect(ranges.first.comments).to eq(subject.comments)
        expect(ranges.last.comments).to eq(another_range.comments)
      end
    end
  end

  # The only purpose of this test is to cover the overrided save_params method
  describe 'save' do
    subject {FactoryGirl.build(:range)}

    before :each do
      KalibroClient::Entities::Configurations::KalibroRange.
        expects(:request).
        with('', {:kalibro_range => subject.to_hash, :metric_configuration_id => subject.metric_configuration_id}, :post, "metric_configurations/#{subject.metric_configuration_id}", {}).
        returns("kalibro_range" => { 'id' => 2, 'kalibro_errors' => []})
    end

    it 'should make a request to save model with id and return true without errors' do
      expect(subject.save).to be(true)
      expect(subject.kalibro_errors).to be_empty
    end
  end

  # The only purpose of this test is to cover the overrided destroy_prefix method
  describe 'destroy' do
    subject {FactoryGirl.build(:range_with_id)}

    before :each do
      KalibroClient::Entities::Configurations::KalibroRange.
        expects(:request).
        with(":id", {id: subject.id}, :delete, "metric_configurations/#{subject.metric_configuration_id}", {}).returns({})
    end

    it 'should make a request to destroy' do
      subject.destroy
    end
  end

  # The only purpose of this test is to cover the overrided update_params method
  describe 'update' do
    subject {FactoryGirl.build(:range_with_id)}

    before :each do
      subject.end = "555"
      KalibroClient::Entities::Configurations::KalibroRange.
        expects(:request).
        with(':id', {:kalibro_range => subject.to_hash, :id => subject.id}, :put, "metric_configurations/#{subject.metric_configuration_id}", {}).
        returns("errors" => nil)
    end

    it 'should make a request to update the model and return true without errors' do
      expect(subject.update).to be(true)
      expect(subject.kalibro_errors).to be_empty
    end
  end

  describe 'range' do
    context 'with finite beginning and end' do
      subject { FactoryGirl.build(:range) }

      it 'should create a Range object using the boundaries' do
        expect(subject.range).to eq(Range.new(subject.beginning.to_f, subject.end.to_f, exlude_end: true))
      end
    end
    context 'with infinite beginning and/or end' do
      subject { FactoryGirl.build(:range, beginning: "-INF", end: "INF") }

      it 'should create a Range object using the boundaries' do
        expect(subject.range).to eq(Range.new(-Float::INFINITY, Float::INFINITY, exlude_end: true))
      end
    end
  end
end
