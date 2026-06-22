class ClientInvolvementTypesController < ApplicationController
  def index
    result = ClientInvolvementTypeService.call(nil)
    render json: result, status: :ok
  end

  def show
    response = ClientInvolvementTypeService.call(params[:proceeding_type_ccms_code])
    status = response[:success] ? 200 : 400
    render json: response, status:
  end

  def filter
    response = ClientInvolvementTypeService.call(proceeding_type_ccms_code, age)
    status = response[:success] ? 200 : 400
    render json: response, status:
  end

private

  def proceeding_type_ccms_code
    params.require(:proceeding_type_ccms_code)
  rescue ActionController::ParameterMissing
    ""
  end

  def age
    params.require(:age)
  rescue ActionController::ParameterMissing
    nil
  end
end
