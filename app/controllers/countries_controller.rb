class CountriesController < ApplicationController
  def index
    result = Country.order(:description).map(&:api_json)
    render json: result, status: :ok
  end
end
