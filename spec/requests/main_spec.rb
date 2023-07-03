# frozen_string_literal: true

require "rails_helper"

RSpec.describe "MainController" do
  describe "GET /" do
    it "redirects to the api-docs" do
      get root_path
      expect(response).to redirect_to("/api-docs")
    end
  end
end
