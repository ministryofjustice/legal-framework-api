require 'rails_helper'

RSpec.describe 'ProceedingTypes/SearchController', type: :request do
  before { seed_live_data }
  describe 'POST proceeding_types/search' do
    let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
    let(:params) do
      {
        search_term: search_term
      }
    end
    let(:search_term) { 'Occupation' }
    subject { post proceeding_types_searches_path, params: params.to_json, headers: headers }

    context 'when the params are valid' do
      before { subject }
      let(:expected_result) do
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
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(200)
        expect(response.media_type).to eql('application/json')
        expect(JSON.parse(response.body)).to match_json_expression(expected_result)
      end
    end

    context 'when no matches found' do
      before { subject }
      let(:search_term) { 'nonexistant' }
      let(:expected_result) do
        {
          success: false,
          error: 'no matches found'
        }
      end

      it 'returns an unsuccessful response' do
        expect(response).to have_http_status(400)
        expect(response.media_type).to eql('application/json')
        expect(JSON.parse(response.body)).to match_json_expression(expected_result)
      end
    end

    context 'when an error occurs' do
      before do
        allow(ProceedingTypeFullTextSearch).to receive(:call).and_raise(StandardError.new('Unexpected error in full text search'))
        subject
      end
      let(:expected_result) do
        {
          success: false,
          error: 'StandardError',
          message: 'Unexpected error in full text search'
        }
      end

      it 'returns an unsuccessful response' do
        expect(response).to have_http_status(400)
        expect(response.media_type).to eql('application/json')
        expect(JSON.parse(response.body)).to match_json_expression(expected_result)
      end
    end

    context 'when returning multiple results' do
      before { subject }
      let(:search_term) { 'injunction' }

      it 'returns a successful response with three results' do
        expect(response).to have_http_status(200)
        expect(response.media_type).to eql('application/json')
        expect(JSON.parse(response.body).symbolize_keys[:data].count).to eq 3
      end

      context 'and one of the codes is excluded' do
        let(:params) do
          {
            search_term: 'injunction',
            excluded_terms: 'DA001'
          }
        end

        it 'returns a successful response with two results' do
          expect(response).to have_http_status(200)
          expect(response.media_type).to eql('application/json')
          expect(JSON.parse(response.body).symbolize_keys[:data].count).to eq 2
        end
      end
    end

    context 'when sending excluded_terms' do
      describe 'that should return a single match' do
        before { subject }
        let(:params) do
          {
            search_term: search_term,
            excluded_terms: 'DA005'
          }
        end
        let(:expected_result) do
          {
            success: false,
            error: 'no matches found'
          }
        end

        it 'returns an unsuccessful response' do
          expect(response).to have_http_status(400)
          expect(response.media_type).to eql('application/json')
          expect(JSON.parse(response.body)).to match_json_expression(expected_result)
        end
      end
    end
  end
end
