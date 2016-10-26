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

describe KalibroClient::Entities::Configurations::ReadingGroup do
  describe "id=" do
    subject { FactoryGirl.build(:reading_group_with_id) }

    it 'should set the id attribute values as an integer' do
      subject.id = "222"
      expect(subject.id).to eq(222)
    end
  end

  describe 'readings' do
    let(:reading_group) { FactoryGirl.build(:reading_group_with_id) }

    context 'with readings' do
      let(:reading_1) { FactoryGirl.build(:reading, reading_group_id: reading_group.id) }
      let(:reading_2) { FactoryGirl.build(:reading, reading_group_id: reading_group.id) }

      before :each do
        KalibroClient::Entities::Configurations::ReadingGroup.expects(:request).with(":id/readings", {id: reading_group.id}, :get).returns({"readings" => [reading_1.to_hash, reading_2.to_hash]})
      end

      it 'should return an array of readings' do
        expect(reading_group.readings).to eq([reading_1, reading_2])
      end
    end

    context 'without readings' do
      before :each do
        KalibroClient::Entities::Configurations::ReadingGroup.expects(:request).with(":id/readings", {id: reading_group.id}, :get).returns({"readings" => []})
      end

      it 'should return an empty array' do
        expect(reading_group.readings).to eq([])
      end
    end
  end
end
