class ClientInvolvementTypesController < ApplicationController
  def index
    result = ClientInvolvementType.all.map(&:api_json)
    render json: result, status: :ok
  end
end
