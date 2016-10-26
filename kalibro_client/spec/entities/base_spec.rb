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

# Create a class that has the attribute assignment methods, since some methods expect they exist
# (and usually the subclasses do that).

class MiscellaneousTest < KalibroClient::Entities::Miscellaneous::Base
  attr_accessor :id
end

class BaseTest < KalibroClient::Entities::Base
  attr_accessor :id, :miscellaneous
end

describe KalibroClient::Entities::Base do
  subject { BaseTest.new }

  before do
    subject.id = 24
    subject.miscellaneous = MiscellaneousTest.new
    subject.miscellaneous.id = 42
  end

  describe 'class method' do
    describe 'module_name' do
      it 'is expected to return the camelized gem name' do
        expect(described_class.module_name).to eq('KalibroClient')
      end
    end
  end

  describe 'instance method' do
    describe 'convert_to_hash' do
      it 'is expected to convert miscellaneous nested objects' do
        expect(subject.to_hash).to eq({'id' => "24", 'miscellaneous' => {'id' => "42"}})
      end
    end
  end
end
