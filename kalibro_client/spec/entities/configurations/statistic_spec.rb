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

describe KalibroClient::Entities::Configurations::Statistic do
  describe 'metric_percentage' do
    let(:metric_code) {"bf"}

    before :each do
      KalibroClient::Entities::Configurations::Statistic.
      expects(:request).
      with('/metric_percentage', {metric_code: metric_code}, :get).
      returns({"metric_percentage" => 100})
    end

    it 'should return an array containing the percentage' do
      expect(KalibroClient::Entities::Configurations::Statistic.
      metric_percentage(metric_code)).to eq({"metric_percentage" => 100})
    end
  end
end
