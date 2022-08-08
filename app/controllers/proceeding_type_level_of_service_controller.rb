class ProceedingTypeLevelOfServiceController < ApplicationController
  def create
    response = ProceedingTypeServiceLevelService.call(proceeding_type_level_of_service_params: request.raw_post)
    status = response[:success] ? 200 : 400
    render json: response, status:
  end
end
