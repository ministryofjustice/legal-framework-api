class ProceedingTypeDefaultsController < ApplicationController
  def create
    response = ProceedingTypeDefaultsService.call(proceeding_type_defaults_params: request.raw_post)
    status = response[:success] ? 200 : 400
    render json: response, status:
  end
end
