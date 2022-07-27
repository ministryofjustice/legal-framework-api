class ClientInvolvementTypesController < ApplicationController
  def index
    result = ClientInvolvementType.order(:ordering).map { |cit| JSON.parse(cit.api_json) }
    render json: result, status: :ok
  end
end
