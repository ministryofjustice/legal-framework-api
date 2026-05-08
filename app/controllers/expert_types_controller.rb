class ExpertTypesController < ApplicationController
  def index
    result = ExpertType.order(:description).map(&:api_json)
    render json: result, status: :ok
  end

  def by_matter_type
    result = ExpertType.for_matter_type(params[:matter_type]).order(:description).map(&:api_json)
    render json: result, status: :ok
  end
end
