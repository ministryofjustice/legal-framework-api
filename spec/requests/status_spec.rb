# frozen_string_literal: true

require "rails_helper"

RSpec.describe "StatusController" do
  describe "GET /satus" do
    context "when database is available" do
      let(:expected_response) { { "checks" => { "database" => true } } }

      it "returns ok" do
        get status_path
        expect(response.parsed_body).to eq expected_response
      end
    end

    context "when database is down" do
      let(:expected_response) { { "checks" => { "database" => false } } }

      it "returns false" do
        allow(ActiveRecord::Base).to receive(:connection).and_raise(PG::ConnectionBad, "Error")
        get status_path
        expect(response.parsed_body).to eq expected_response
      end
    end
  end

  describe "GET /ping" do
    let(:build_date) { Time.zone.now }
    let(:build_tag) { "app-43ca8c7bfbee8f5fcb96b76baa420c3a45d8a675" }
    let(:app_branch) { "my-branch" }
    let(:expected_response) do
      {
        build_date:,
        build_tag:,
        app_branch:,
      }
    end

    before do
      allow(Rails.configuration.x.status).to receive(:build_date).and_return(build_date)
      allow(Rails.configuration.x.status).to receive(:build_tag).and_return(build_tag)
      allow(Rails.configuration.x.status).to receive(:app_branch).and_return(app_branch)
    end

    it "returns build stats as a JSON body" do
      get ping_path
      expect(response.body).to eq expected_response.to_json
    end
  end
end
