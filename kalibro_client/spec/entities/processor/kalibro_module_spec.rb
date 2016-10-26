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

describe KalibroClient::Entities::Processor::KalibroModule do
  subject { FactoryGirl.build(:kalibro_module, long_name: "a.long.name") }

  describe 'name=' do
    context 'with an array value' do
      it 'is expected to set the long_name to a string of joined elements of the array' do
        value = subject.long_name.split(".")
        subject.name = value
        expect(subject.long_name).to eq("a.long.name")
      end
    end

    context 'with a string value' do
      it 'is expected to set the long_name to the string passed as argument' do
        value = subject.long_name
        subject.name = value
        expect(subject.long_name).to eq("a.long.name")
      end
    end
  end

  describe 'name' do
    it 'should return an array of the entire path' do
      expect(subject.name).to eq(subject.long_name.split("."))
    end
  end

  describe 'short_name' do
    it 'should return the last element of the name array' do
      expect(subject.short_name).to eq(subject.long_name.split(".").last)
    end
  end

  describe 'granularity' do
    it 'is expected to be a granularity object' do
      expect(subject.granularity).to be_a KalibroClient::Entities::Miscellaneous::Granularity
    end
  end
end
