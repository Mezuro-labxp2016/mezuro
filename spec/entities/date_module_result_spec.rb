# This file is part of KalibroGatekeeperClient
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

describe KalibroGatekeeperClient::Entities::DateModuleResult do
  describe 'date=' do
    context 'when the given value is a String' do
      it 'should set the date and convert it to DateTime' do
        subject.date = "21/12/1995" # Ruby's first publication

        expect(subject.date).to be_a(DateTime)
        expect(subject.date).to eq(DateTime.parse("21/12/1995"))
      end
    end

    context 'when the given value is something else than a String' do
      it 'should just set the value' do
        subject.date = :something_else

        expect(subject.date).to eq(:something_else)
      end
    end
  end

  describe 'module_result=' do
    let(:module_result) { FactoryGirl.build(:module_result) }
    before :each do
      KalibroGatekeeperClient::Entities::ModuleResult.
        expects(:to_object).
        with(module_result.to_hash).
        returns(module_result)
    end

    it 'should set the module_result with the given one' do
      subject.module_result = module_result.to_hash
      expect(subject.module_result).to eq(module_result)
    end
  end

  describe 'result' do
    subject {FactoryGirl.build(:date_module_result)}

    it 'should return the module_result grade' do
      expect(subject.result).to eq(10)
    end
  end
end