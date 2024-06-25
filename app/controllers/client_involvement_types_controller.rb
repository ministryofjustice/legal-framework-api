class ClientInvolvementTypesController < ApplicationController
  def index
    result = ClientInvolvementType.order(:ordering).map(&:api_json)
    render json: result, status: :ok
  end

  def show
    response = ClientInvolvementTypeService.call(params[:proceeding_type_ccms_code])
    status = response[:success] ? 200 : 400
    render json: response, status:
  end
end
