class ProceedingTypeLevelsOfServiceController < ApplicationController
  def create
    response = ProceedingTypeServiceLevelsService.call(proceeding_type_levels_of_service_params: request.raw_post)
    status = response[:success] ? 200 : 400
    render json: response, status:
  end
end
