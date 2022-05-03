# frozen_string_literal: true

class ProceedingTypesController < ApplicationController
  def show
    response = ProceedingTypeService.call(params[:ccms_code])
    status = response[:success] ? 200 : 400
    render json: response, status:
  end
end
