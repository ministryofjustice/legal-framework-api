# frozen_string_literal: true

class ProceedingTypesController < ApplicationController
  resource_description do
    description <<-END_OF_TEXT
    == Description
      This endpoint accepts a ccms_code and returns proceeding_type data.

        GET /proceeding_type/ccms_code

    END_OF_TEXT
  end
  api :GET, 'proceeding_type', 'Create a request to retrieve the Proceeding Type information for a specific proceeding'
  param :ccms_code, String, required: true
  formats(%w[json])

  returns code: :ok, desc: 'Successful response' do # rubocop:disable Metrics/BlockLength
    property :ccms_code, String, desc: 'The ccms_code specified in the request'
    property :success, ['true'], desc: 'Success flag shows true'
    property :meaning, String, desc: 'The Proceeding Type meaning'
    property :ccms_category_law_code, String, desc: 'The Proceeding Type CCMS category of law code'
    property :ccms_matter_code, String, desc: 'The Proceeding Type CCMS matter code'
    property :name, String, desc: 'The Proceeding Type name'
    property :description, String, desc: 'The Proceeding Type description'
    property :ccms_category_law, String, desc: 'The Proceeding Type CCMS category of law'
    property :ccms_matter, String, desc: 'The Proceeding Type CCMS matter type'
    property :cost_limitations, Hash, desc: 'List of applicable cost limitations' do
      property :substantive, Hash, desc: 'Cost limitations of a substantive proceeding' do
        property :start_date, String, desc: 'The start date for the substantive cost limitation'
        property :value, String, desc: 'The substantive cost limitations value'
      end
      property :delegated_functions, Hash, desc: 'Cost limitations of a delegated functions proceeding' do
        property :start_date, String, desc: 'The start date for the delegated functions cost limitation'
        property :value, String, desc: 'The delegated functions cost limitations value'
      end
    end
    property :default_scope_limitations, Hash, desc: 'List of default_scope_limitations' do
      property :substantive, Hash, desc: 'Scope limitations of a substantive proceeding' do
        property :code, String, desc: 'The code for the substantive scope limitation'
        property :meaning, String, desc: 'The meaning for the substantive scope limitation'
        property :description, String, desc: 'The substantive scope limitations description'
      end
      property :delegated_functions, Hash, desc: 'Scope limitations of a delegated functions proceeding' do
        property :code, String, desc: 'The code for the delegated functions scope limitation'
        property :meaning, String, desc: 'The meaning of the delegated functions scope limitation'
        property :description, String, desc: 'The delegated functions scope limitations description'
      end
    end
  end

  returns code: :bad_request do
    property :request_id, :uuid, desc: 'The request_id specified in the request'
    property :success, ['false'], desc: 'Success flag shows false'
    property :error_class, String, desc: 'Name of the error class that caused the exception'
    property :message, String, desc: 'Error message'
    property :backtrace, array_of: String, desc: 'Backtrace of exception'
  end

  def show
    response = ProceedingTypeService.call(params[:ccms_code])
    status = response[:success] ? 200 : 400
    render json: response, status: status
  end
end
