class ClientInvolvementTypesController < ApplicationController
  def index
    result = ClientInvolvementType.all.map { |cit| cit.api_json }
    render json: result, status: :ok
  end
end
