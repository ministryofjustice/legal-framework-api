module ProceedingTypes
  class ThresholdWaiversController < ApplicationController
    def create
      history = RequestHistory.record_request(request_id, request)
      response = ThresholdWaiverService.call(request_id, ccms_codes)
      status = response[:success] ? 200 : 400
      history.record_response(status, response)
      render json: response, status:
    end

  private

    def request_id
      params[:request_id]
    end

    def ccms_codes
      params[:proceeding_types]
    end
  end
end
