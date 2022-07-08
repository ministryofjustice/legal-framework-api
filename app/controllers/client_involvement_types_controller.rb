class ClientInvolvementTypesController < ApplicationController
  def index
    result = ClientInvolvementType.all.map { |cit| JSON.parse(cit.api_json) }
    render json: result.to_json, status: :ok
  end
end
