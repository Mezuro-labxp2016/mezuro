require 'rspec/mocks'
require 'faraday'
require 'likeno'
require 'kalibro_client/kalibro_cucumber_helpers'

describe KalibroClient::KalibroCucumberHelpers::Cleaner do
  let(:address_key) { :test_address }
  let(:likeno_config) { {address_key => 'http://test'} }

  subject { described_class.new(address_key) }

  describe 'endpoint' do
    it 'is expected to return "tests"' do
      expect(subject.endpoint).to eq('tests')
    end
  end

  describe 'address' do
    it 'is expected to find the address in Likeno' do
      Likeno.expects(:config).returns likeno_config
      expect(subject.address).to eq(likeno_config[address_key])
    end
  end

  describe 'clean_database' do
    it 'is expected to make a request to the correct address' do
      subject.expects(:request).with('clean_database',  {}, :post)

      subject.clean_database
    end
  end
end
