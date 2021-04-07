class StatusController < ApplicationController
  def status
    checks = {
      database: database_alive?
    }
    status = :bad_gateway unless checks.values.all?
    render status: status, json: { checks: checks }
  end

  def ping
    render json: {
      'build_date' => ENV['BUILD_DATE'] || 'Not Available',
      'build_tag' => ENV['BUILD_TAG'] || 'Not Available',
      'app_branch' => ENV['APP_BRANCH'] || 'Not Available'
    }
  end

  private

  def database_alive?
    ActiveRecord::Base.connection.active?
  rescue PG::ConnectionBad
    false
  end
end
