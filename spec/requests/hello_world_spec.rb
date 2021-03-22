# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HelloWorldController, type: :request do
  describe 'GET /hello_world' do
    let(:expected_response) do
      {
        success: true,
        message: 'Hello World'
      }.stringify_keys
    end

    it 'returns success' do
      get hello_world_path
      expect(response).to be_successful
    end

    it 'returns expected structure' do
      get hello_world_path
      expect(JSON.parse(response.body)).to eq expected_response
    end
  end
end
