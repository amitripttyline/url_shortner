require 'swagger_helper'

RSpec.describe 'API V1 URLs', type: :request do
  path '/api/v1/urls' do
    post 'Create a short URL' do
      tags 'URL Shortener'
      consumes 'application/json'
      parameter name: :url, in: :body, schema: {
        type: :object,
        properties: {
          original_url: { type: :string }
        },
        required: ['original_url']
      }
      security [bearer_auth: []]

      response '201', 'short URL created' do
        let(:Authorization) { "Bearer some_valid_token" }
        let(:url) { { original_url: 'https://example.com' } }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { nil }
        let(:url) { { original_url: 'https://example.com' } }
        run_test!
      end
    end
  end
end
