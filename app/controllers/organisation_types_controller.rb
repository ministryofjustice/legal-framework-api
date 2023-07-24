class OrganisationTypesController < ApplicationController
  def index
    result = OrganisationType.order(:description).map(&:api_json)
    render json: result, status: :ok
  end

  def show
    response = OrganisationTypeService.call(params[:ccms_code])
    status = response[:success] ? 200 : 400
    render json: response, status:
  end
end
