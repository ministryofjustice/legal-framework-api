class ThresholdWaiversController < ApplicationController
  def create
    history = RequestHistory.record_request(request_id, request)
    response = ThresholdWaiverService.call(request_id, data_pairs)
    status = response[:success] ? 200 : 400
    history.record_response(status, response)
    render json: response, status:
  end

private

  def request_id
    params.require(:request_id)
  end

  def data_pairs
    params.require(:proceedings)
  end
end
