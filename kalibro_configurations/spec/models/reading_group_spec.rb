require 'rails_helper'

RSpec.describe ReadingGroup do
  describe 'associations' do
    it { is_expected.to have_many(:readings).dependent(:destroy) }
    it { is_expected.to have_many(:metric_configurations) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
