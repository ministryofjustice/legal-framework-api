class CivilMeritsQuestionsController < ApplicationController
  def create
    history = RequestHistory.record_request(request_id, request)
    response = QuestionsService.call(request.raw_post)
    status = response[:success] ? 200 : 400
    history.record_response(status, response)
    render json: response, status:
  end

private

  def request_id
    params[:request_id]
  end
end
