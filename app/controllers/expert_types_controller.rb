class ExpertTypesController < ApplicationController
  def index
    result = ExpertType.order(:description).map(&:api_json)
    render json: result, status: :ok
  end
end
