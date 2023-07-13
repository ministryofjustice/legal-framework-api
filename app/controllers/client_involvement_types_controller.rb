class ClientInvolvementTypesController < ApplicationController
  def index
    result = ClientInvolvementType.order(:ordering).map(&:api_json)
    render json: result, status: :ok
  end
end
