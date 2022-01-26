class RequestHistory < ApplicationRecord
  def self.record_request(request_id, http_request)
    create!(request_method: http_request.request_method,
            request_id:,
            endpoint: http_request.fullpath,
            remote_ip: http_request.remote_ip,
            request_payload: http_request.raw_post)
  end

  def record_response(status, response)
    update!(response_status: status, response_payload: response.to_json)
  end

  def self.request_payload(http_request)
    http_request.filtered_parameters.except('controller').except('action').to_json
  end
end
