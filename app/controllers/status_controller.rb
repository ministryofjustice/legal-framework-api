class StatusController < ApplicationController
  def status
    checks = {
      database: database_alive?,
    }
    status = :bad_gateway unless checks.values.all?
    render status:, json: { checks: }
  end

  def ping
    render json: {
      "build_date" => Rails.configuration.x.status.build_date,
      "build_tag" => Rails.configuration.x.status.build_tag,
      "app_branch" => Rails.configuration.x.status.app_branch,
    }
  end

private

  def database_alive?
    ActiveRecord::Base.connection.active?
  rescue PG::ConnectionBad
    false
  end
end
