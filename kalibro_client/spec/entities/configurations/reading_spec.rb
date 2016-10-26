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

describe KalibroClient::Entities::Configurations::Reading do
  describe "id=" do
    it 'should set the id attribute as an integer' do
      subject.id = "44"
      expect(subject.id).to eq(44)
    end
  end

  context 'static methods' do
    let(:reading) { FactoryGirl.build(:reading_with_id) }
    describe 'readings_of' do
      let(:reading_group) { FactoryGirl.build(:reading_group_with_id) }

      before do
        KalibroClient::Entities::Configurations::Reading.
          expects(:request).
          with('', {}, :get, "reading_groups/#{reading_group.id}").
          returns({'readings' => [reading.to_hash, reading.to_hash]})
      end

      it 'should returns a list of readings that belongs to the given reading group' do
        response = KalibroClient::Entities::Configurations::Reading.readings_of reading_group.id
        expect(response.first.label).to eq(reading.label)
        expect(response.last.label).to eq(reading.label)
      end
    end
  end

  # The only purpose of this test is to cover the overrided save_params method
  describe 'save' do
    let(:reading) { FactoryGirl.build(:reading, {reading_group_id: FactoryGirl.build(:reading_group_with_id).id}) }
    let(:reading_id) { 73 }

    before :each do
      KalibroClient::Entities::Configurations::Reading.
        expects(:request).
        with('', {reading: reading.to_hash, reading_group_id: reading.reading_group_id}, :post, "reading_groups/#{reading.reading_group_id}", {}).
        returns("reading" => {'id' => reading_id, 'kalibro_errors' => []})
    end

    it 'should make a request to save model with id and return true without errors' do
      expect(reading.save).to be(true)
      expect(reading.id).to eq(reading_id)
      expect(reading.kalibro_errors).to be_empty
    end
  end

  # The only purpose of this test is to cover the overrided destroy_prefix method
  describe 'destroy' do
    subject {FactoryGirl.build(:reading_with_id)}

    before :each do
      KalibroClient::Entities::Configurations::Reading.
        expects(:request).
        with(":id", {id: subject.id}, :delete, "reading_groups/#{subject.reading_group_id}", {}).returns({})
    end

    it 'should make a request to destroy' do
      subject.destroy
    end
  end

  # The only purpose of this test is to cover the overridden update_prefix method
  describe 'update' do
    subject {FactoryGirl.build(:reading_with_id)}

    before :each do
      KalibroClient::Entities::Configurations::Reading.
        expects(:request).
        with(":id", {reading: subject.to_hash, id: subject.id}, :put, "reading_groups/#{subject.reading_group_id}", {}).returns({})
    end

    it 'should make a request to update' do
      subject.update
    end
  end
end
