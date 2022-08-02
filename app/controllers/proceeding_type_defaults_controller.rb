class ProceedingTypeDefaultsController < ApplicationController
  def create
    response = ProceedingTypeDefaultsService.call(proceeding_type_ccms_code:, delegated_functions_used:, client_involvement_type:, level_of_service_code:)
    status = response[:success] ? 200 : 400
    render json: response, status:
  end

private

  def proceeding_type_ccms_code
    params.require(:proceeding_type_ccms_code)
  end

  def delegated_functions_used
    params.require(:delegated_functions_used)
  end

  def client_involvement_type
    params.require(:client_involvement_type)
  end

  def level_of_service_code
    params.require(:level_of_service_code)
  end
end
