class ProceedingTypeScopesController < ApplicationController
  def create
    response = ProceedingTypeScopesService.call(proceeding_type_scopes_params: request.raw_post)
    status = response[:success] ? 200 : 400
    render json: response, status:
  end
end
