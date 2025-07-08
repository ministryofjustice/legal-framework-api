class CountriesController < ApplicationController
  def index
    result = Country.order(:description).map(&:api_json)
    render json: result, status: :ok
  end

  def create
    render status:, json: { success: }.merge(results).to_json
  end

private

  def success
    @success ||= status.eql?(200) && results.symbolize_keys[:data].any?
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
    @build_results ||= CountriesFullTextSearch.call(search_param)
  end

  def search_param
    params.require(:search_term)
  end
end
