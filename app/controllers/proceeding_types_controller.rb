# frozen_string_literal: true

class ProceedingTypesController < ApplicationController
  resource_description do
    description <<-END_OF_TEXT
    == Description
      This endpoint accepts a ccms_code and returns proceeding_type data.

        GET /proceeding_type/ccms_code

    END_OF_TEXT
  end
  api :GET, 'proceeding_type'
  param :ccms_code, String, required: true
  formats(%w[json])

  def show
    response = ProceedingTypeService.call(params[:ccms_code])
    status = response[:success] ? 200 : 400
    render json: response, status: status
  end
end
