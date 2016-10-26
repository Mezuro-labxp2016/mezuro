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

describe KalibroClient::Entities::Processor::Repository do
  subject { FactoryGirl.build(:repository) }
  let(:date) { DateTime.now }

  describe 'repository_types' do
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with('types', {}, :get).
        returns({'types'=>["BAZAAR", "GIT", "MERCURIAL", "REMOTE_TARBALL", "REMOTE_ZIP"]})
    end

    it 'should return an array of repository types' do
      expect(KalibroClient::Entities::Processor::Repository.repository_types).to eq(["BAZAAR", "GIT", "MERCURIAL", "REMOTE_TARBALL", "REMOTE_ZIP"])
    end
  end

  describe 'repositories_of' do
    let!(:project) { FactoryGirl.build(:project_with_id) }
    let!(:repository_hash) { FactoryGirl.attributes_for(:repository_with_id) }
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with('', {}, :get, "projects/#{project.id}").
        returns({'repositories' => [repository_hash]})
    end

    it 'should return an array' do
      expect(KalibroClient::Entities::Processor::Repository.repositories_of(project.id)).to be_an(Array)
    end

    it 'should set the repository_id' do
      KalibroClient::Entities::Processor::Repository.repositories_of(project.id).each do |repository|
        expect(repository.project_id).to eq(project.id)
      end
    end
  end

  describe "id=" do
    it 'should set the id attribute values as integer' do
      subject.id = "222"
      expect(subject.id).to eq(222)
    end
  end

  describe "period=" do
    it 'should set the period attribute values as integer' do
      subject.period = "222"
      expect(subject.period).to eq(222)
    end
  end

  describe "kalibro_configuration_id=" do
    it 'should set the kalibro_configuration_id attribute values as integer' do
      subject.kalibro_configuration_id = "222"
      expect(subject.kalibro_configuration_id).to eq(222)
    end
  end

  describe 'process' do
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with("#{subject.id}/process", {}, :get)
    end

    it 'should call the request method' do
      subject.process
    end
  end

  describe 'cancel_processing_of_repository' do
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with(':id/cancel_process', {id: subject.id}, :get)
    end

    it 'should call the request method' do
      subject.cancel_processing_of_repository
    end
  end

  # The only purpose of this test is to cover the overrided save_params method
  describe 'save' do
    subject {FactoryGirl.build(:repository)}

    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).
        with('', {:repository => subject.to_hash, :project_id => 1}, :post, '', {}).
        returns("repository" => {'id' => 1, 'kalibro_errors' => []})

      KalibroClient::Entities::Processor::Repository.any_instance.
        expects(:id=).
        with(1).
        returns(1)
    end

    it 'should make a request to save model with id and return true without errors' do
      expect(subject.save).to be(true)
      expect(subject.kalibro_errors).to be_empty
    end
  end

  describe 'has_processing' do
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).once.
        with("#{subject.id}/has_processing", {}, :get).
        returns({'has_processing' => false})
    end

    it 'should convert the hash to a Boolean class' do
      response = subject.has_processing
      expect(response).to be_a_kind_of(FalseClass)
    end
  end

  describe 'has_ready_processing' do
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).once.
        with("#{subject.id}/has_ready_processing", {}, :get).
        returns({'has_ready_processing' => false})
    end

    it 'should convert the hash to a Boolean class' do
      response = subject.has_ready_processing
      expect(response).to be_a_kind_of(FalseClass)
    end
  end

  describe 'has_processing_after' do
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).once.
        with("#{subject.id}/has_processing/after", {date: date}).
        returns({'has_processing_in_time' => false})
    end

    it 'should convert the hash to a Boolean class' do
      response = subject.has_processing_after(date)
      expect(response).to be_a_kind_of(FalseClass)
    end
  end

  describe 'has_processing_before' do
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).once.
        with("#{subject.id}/has_processing/before", {date: date}).
        returns({'has_processing_in_time' => false})
    end

    it 'should convert the hash to a Boolean class' do
      response = subject.has_processing_before(date)
      expect(response).to be_a_kind_of(FalseClass)
    end
  end

  describe 'last_processing_state' do
    let(:any_state)  { "READY" }
    before :each do
      KalibroClient::Entities::Processor::Repository.
        expects(:request).once.
        with("#{subject.id}/last_processing_state", {}, :get).
        returns({'processing_state' => any_state})
    end

    it 'should return the state as string' do
      response = subject.last_processing_state
      expect(response).to eq(any_state)
    end
  end

  context 'getting processing entity from Kalibro web service' do
    let(:processing) { FactoryGirl.build(:processing) }

    describe 'processing' do
      context 'when the repository has a ready processing' do
        before do
          KalibroClient::Entities::Processor::Repository.
            expects(:request).once.
            with("#{subject.id}/has_ready_processing", {}, :get).
            returns({'has_ready_processing' => true})

          KalibroClient::Entities::Processor::Repository.
            expects(:request).once.
            with(':id/last_ready_processing', {id: subject.id}, :get).
            returns({'last_ready_processing' => processing.to_hash})
        end

        it 'should return the last ready processing' do
          response = subject.processing
          expect(response.state).to eq(processing.state)
        end
      end

      context 'when the repository has not a ready processing' do
        before do
          KalibroClient::Entities::Processor::Repository.
            expects(:request).once.
            with("#{subject.id}/has_ready_processing", {}, :get).
            returns({'exists' => false})

          KalibroClient::Entities::Processor::Repository.
            expects(:request).once.
            with("#{subject.id}/last_processing").
            returns({'processing' => processing.to_hash})
        end

        it 'should return the last processing' do
          response = subject.processing
          expect(response.state).to eq(processing.state)
        end
      end
    end

    describe 'processing_with_date' do
      context 'when the repository has a processing after the given date' do
        before do
          KalibroClient::Entities::Processor::Repository.
            expects(:request).once.
            with("#{subject.id}/has_processing/after", {date: date}).
            returns({'has_processing_in_time' => true})

          KalibroClient::Entities::Processor::Repository.
            expects(:request).once.
            with("#{subject.id}/first_processing/after", {date: date}).
            returns({'processing' => processing.to_hash})
        end

        it 'should return the first processing after the given date' do
          response = subject.processing_with_date(date)
          expect(response.state).to eq(processing.state)
        end
      end

      context 'when the repository has a processing before the given date' do
        before do
          KalibroClient::Entities::Processor::Repository.
            expects(:request).once.
            with("#{subject.id}/has_processing/after", {date: date}).
            returns({'has_processing_in_time' => false})

          KalibroClient::Entities::Processor::Repository.
            expects(:request).once.
            with("#{subject.id}/has_processing/before", {date: date}).
            returns({'has_processing_in_time' => true})

          KalibroClient::Entities::Processor::Repository.
            expects(:request).once.
            with("#{subject.id}/last_processing/before", {date: date}).
            returns({'processing' => processing.to_hash})
        end

        it 'should return the last ready processing' do
          response = subject.processing_with_date(date)
          expect(response.state).to eq(processing.state)
        end
      end

      context 'when the repository has not a processing after or before the given date' do
        before do
          KalibroClient::Entities::Processor::Repository.
            expects(:request).once.
            with("#{subject.id}/has_processing/after", {date: date}).
            returns({'has_processing_in_time' => false})

          KalibroClient::Entities::Processor::Repository.
            expects(:request).once.
            with("#{subject.id}/has_processing/before", {date: date}).
            returns({'has_processing_in_time' => false})
        end

        it 'should return the last ready processing' do
          response = subject.processing_with_date(date)
          expect(response).to be_nil
        end
      end
    end

    describe 'last_ready_processing' do
      before :each do
        KalibroClient::Entities::Processor::Repository.
          expects(:request).once.
          with(':id/last_ready_processing', {id: subject.id}, :get).
          returns({'last_ready_processing' => processing.to_hash})
      end

      it 'should return a processing object' do
        response = subject.last_ready_processing
        expect(response.state).to eq(processing.state)
      end
    end

    describe 'first_processing' do
      before :each do
        KalibroClient::Entities::Processor::Repository.
          expects(:request).once.
          with("#{subject.id}/first_processing").
          returns({'processing' => processing.to_hash})
      end

      it 'should return a processing object' do
        response = subject.first_processing
        expect(response.state).to eq(processing.state)
      end
    end

    describe 'last_processing' do
      before :each do
        KalibroClient::Entities::Processor::Repository.
          expects(:request).once.
          with("#{subject.id}/last_processing").
          returns({'processing' => processing.to_hash})
      end

      it 'should return a processing object' do
        response = subject.last_processing
        expect(response.state).to eq(processing.state)
      end
    end

    describe 'first_processing_after' do
      before :each do
        KalibroClient::Entities::Processor::Repository.
          expects(:request).once.
          with("#{subject.id}/first_processing/after", {date: date}).
          returns({'processing' => processing.to_hash})
      end

      it 'should return a processing object' do
        response = subject.first_processing_after(date)
        expect(response.state).to eq(processing.state)
      end
    end

    describe 'last_processing_before' do
      before :each do
        KalibroClient::Entities::Processor::Repository.
          expects(:request).once.
          with("#{subject.id}/last_processing/before", {date: date}).
          returns({'processing' => processing.to_hash})
      end

      it 'should return a processing object' do
        response = subject.last_processing_before(date)
        expect(response.state).to eq(processing.state)
      end
    end

    describe 'branches' do
      let(:branches) { ['branch1', 'branch2'] }
      let(:url) { 'dummy-url' }
      let(:scm_type) { 'GIT' }

      context 'valid parameters' do
        before :each do
          KalibroClient::Entities::Processor::Repository.
            expects(:request).
            with("/branches", {url: url, scm_type: scm_type}).
            returns({'branches' => branches})
        end

        it 'is expected to return an array of branch names' do
          response = subject.class.branches(url, scm_type)
          expect(response).to eq('branches' => branches)
        end
      end

      context 'invalid parameters' do
        before :each do
          KalibroClient::Entities::Processor::Repository.
            expects(:request).
            with("/branches", {url: url, scm_type: scm_type}).
            returns({'errors' => ['Error']})
        end

        it 'is expected to return an array of branch names' do
          response = subject.class.branches(url, scm_type)
          expect(response).to eq('errors' => ['Error'])
        end
      end
    end
  end
end
