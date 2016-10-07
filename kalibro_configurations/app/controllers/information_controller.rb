class InformationController < ApplicationController
  def data
    respond_with_json Information.data
  end
end
