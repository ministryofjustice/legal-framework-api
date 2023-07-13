class OrganisationTypesController < ApplicationController
  def index
    result = OrganisationType.order(:description).map(&:api_json)
    render json: result, status: :ok
  end
end
