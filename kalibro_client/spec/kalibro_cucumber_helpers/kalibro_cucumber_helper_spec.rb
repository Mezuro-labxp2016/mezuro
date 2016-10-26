require 'rspec/mocks'
require 'faraday'
require 'likeno'
require 'kalibro_client/kalibro_cucumber_helpers'

describe KalibroClient::KalibroCucumberHelpers do
  let(:cleaner) { mock("KalibroClient::KalibroCucumberHelpers::Cleaner") }

  describe 'methods' do
      let(:processor_cleaner) { mock("KalibroClient::KalibroCucumberHelpers::Cleaner") }

      before :each do
        KalibroClient::KalibroCucumberHelpers::Cleaner.expects(:new).returns(cleaner)
        cleaner.expects(:clean_database)
      end

      describe 'clean_processor' do
        it 'is expected to clean the processor database' do
          KalibroClient::KalibroCucumberHelpers.clean_processor
      end

      describe 'clean_configurations' do
        it 'is expected to clean the processor database' do
          KalibroClient::KalibroCucumberHelpers.clean_configurations
        end
      end
    end
  end
end
