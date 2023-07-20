class OrganisationTypesController < ApplicationController
  def index
    result = OrganisationType.order(:description).map(&:api_json)
    render json: result, status: :ok
  end

  def show
    response = organisation_type_response
    status = response[:success] ? 200 : 400
    render json: response, status:
  end

private

  def organisation_type_response
    { success: true, organisation_type: OrganisationType.find_by!(ccms_code: params[:ccms_code]).api_json }
  rescue StandardError => e
    if e.is_a?(ActiveRecord::RecordNotFound)
      { success: false, message: "No such organisation type: '#{params[:ccms_code]}'" }
    else
      { success: false, message: e.message }
    end
  end
end
