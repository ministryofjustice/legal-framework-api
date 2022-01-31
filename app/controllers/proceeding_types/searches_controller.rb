module ProceedingTypes
  class SearchesController < ApplicationController
    resource_description do
      short 'Search proceeding types'
      formats(%w[json])
      description <<-END_OF_TEXT
      == Description
      This endpoint accepts a json field containing a single value, `search_term`
        {
          search_term: 'occup'
        }
      and it will return a success marker and a data array of proceeding_types in json format, e.g.
        {
          success: true,
          data: [
            {
              meaning: 'Occupation order',
              ccms_code: 'DA005',
              description: 'to be represented on an application for an occupation order.',
              ccms_category_law: 'Family',
              ccms_matter: 'Domestic abuse'
            }
          ]
        }

      Optionally you can send an excluded_codes value, this should be a comma separated string or codes to exclude, e.g.
        {
          "search_term": "Family",
          "excluded_codes": "DA001,DA002"
        }
      This will return proceeding terms that match Family but exclude any proceeding types with matching codes
      END_OF_TEXT
    end

    api :POST, 'proceeding_types/search', 'Create a request to retrieve a list of proceeding types that match the search type'
    param :search_term, String, required: false, desc: 'Search for proceeding types matching the `search_term`'

    returns code: :ok, desc: 'Successful response' do
      property :success, %w[true], desc: 'Success flag shows true'
      property :data, array_of: String, desc: 'Returns an array of matching proceeding types'
    end

    returns code: :bad_request do
      property :success, %w[false], desc: 'Success flag shows false'
      property :error_class, String, desc: 'Name of the error class that caused the exception'
      property :message, String, desc: 'Error message'
    end

    def index
      result = ProceedingType.all.map { |pt| JSON.parse(pt.api_json) }
      render json: result.to_json, status: :ok
    end

    def create
      render status: status, json: { success: }.merge(results).to_json
    end

  private

    def success
      @success ||= status.eql?(200) && results.symbolize_keys[:data].count.positive?
    end

    def status
      @status ||= results.symbolize_keys[:error].present? ? 400 : 200
    end

    def results
      if build_results.empty?
        { data: [] }
      else
        { data: build_results }
      end
    rescue StandardError => e
      { error: e.class.to_s, message: e.message }
    end

    def build_results
      find = search_param
      exclude = params['excluded_codes'] ||= []
      @build_results ||= ProceedingTypeFullTextSearch.call(find, exclude)
    end

    def search_param
      params.require(:search_term)
    end
  end
end
