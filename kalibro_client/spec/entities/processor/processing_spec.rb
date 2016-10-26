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

describe KalibroClient::Entities::Processor::Processing do
  subject {FactoryGirl.build(:processing)}
  let(:date) { DateTime.now }
  describe 'id=' do
    it 'should convert the id attribute to integer' do
      subject.id = "41"
      expect(subject.id).to eq 41
    end
  end

  describe 'date=' do
    it 'should set the date attribute' do
      subject.date  = date
      expect(subject.date).to eq date
    end

    it 'should convert strings to date format' do
      subject.date = "2013-09-17T18:26:43.151+00:00"
      expect(subject.date).to be_kind_of(DateTime)
    end
  end

  describe "repository_id=" do
    it 'should set the repository_id attribute values as integer' do
      subject.repository_id = "222"
      expect(subject.repository_id).to eq(222)
    end
  end

  describe 'process_times' do
    let(:process_time) { FactoryGirl.build(:analyzing_process_time) }

    context 'When the process_times is nil' do
      before :each do
        KalibroClient::Entities::Processor::Processing.expects(:request).with(":id/process_times", {id: subject.id}, :get).returns({"process_times" => [process_time.to_hash]})
      end

      it 'should set the process_times attribute as a list of objects' do
        expect(subject.process_times).to eq [process_time]
      end
    end

    context 'When the process_times is not nil' do
      before :each do
        KalibroClient::Entities::Processor::Processing.expects(:request).once.with(":id/process_times", {id: subject.id}, :get).returns({"process_times" => [process_time.to_hash]})
      end

      it 'should return the process_times' do
        subject.process_times
        expect(subject.process_times).to eq [process_time]
      end
    end
  end

  describe 'root_module_result_id=' do
    it 'should set the attribute results root id as an integer' do
      subject.root_module_result_id = "36"
      expect(subject.root_module_result_id).to eq 36
    end
  end
end
