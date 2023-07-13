class OrganisationTypesController < ApplicationController
  # TODO: are we parsing and reparsing JSON unnecssarily here
  # if ap_json returns as_json instead then we do not have to re-parse it
  def index
    result = OrganisationType.order(:description).map { |o| o.api_json }
    render json: result, status: :ok
  end
end
