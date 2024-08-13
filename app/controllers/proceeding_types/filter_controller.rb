module ProceedingTypes
  class FilterController < ApplicationController
    def index
      results = ProceedingTypeFilter.call(proceeding_param, category_param, search_term_param)
      result = if results.empty?
                 { success: false, data: [] }
               else
                 results
               end
      render json: result.to_json, status: :ok
    end

  private

    def proceeding_param
      params.require(:current_proceedings)
    rescue ActionController::ParameterMissing
      []
    end

    def category_param
      params.require(:allowed_categories)
    rescue ActionController::ParameterMissing
      []
    end

    def search_term_param
      params.require(:search_term)
    rescue ActionController::ParameterMissing
      ""
    end
  end
end
