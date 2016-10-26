# This file is part of KalibroClient
# Copyright (C) 2013  it's respectives authors (please see the AUTHORS file)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'spec_helper'

describe KalibroClient::Entities::Processor::Project do
  subject { FactoryGirl.build(:project, {id: 42}) }
  describe 'initialize' do
    it 'should have the id set to 42' do
      expect(subject.id).to eq(42)
    end
  end

  describe 'id=' do
    it 'should set the value of the attribute id as integer' do
      subject.id = "42"
      expect(subject.id).to eq(42)
    end
  end

  describe 'repositories' do
    let(:project) { FactoryGirl.build(:project) }
    let(:repository) { FactoryGirl.build(:repository) }

    context 'with a repository' do

      before :each do
        KalibroClient::Entities::Processor::Project.
          expects(:request).
          with(':id/repositories', {id: project.id}, :get).
          returns({"repositories" => [repository.to_hash]})
      end

      it 'should return a list with repositories' do
        expect(project.repositories).to eq([repository])
      end
    end

    context 'without a repository' do
      before :each do
        KalibroClient::Entities::Processor::Project.
          expects(:request).
          with(':id/repositories', {id: project.id}, :get).
          returns({"repositories" => []})
      end

      it 'should return an empty list' do
        expect(project.repositories).to eq([])
      end
    end
  end

  describe 'update' do
    context 'with attributes' do
      before :each do
        KalibroClient::Entities::Processor::Project.
          expects(:request).
          with(':id', {project: {"name" => "Another Name", "description" => subject.description, "id" => subject.id.to_s}, id: subject.id}, :put, '', {}).
          returns({"project" => {"id" => subject.id, "name" => "Another Name", "kalibro_errors" => []}})
      end

      it 'is expected to have name Another Name' do
        subject.update(name: "Another Name")
        expect(subject.name).to eq("Another Name")
      end
    end
  end
end
