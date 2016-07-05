require "spec_helper"

RSpec.describe Endpoints::Health do
  include Rack::Test::Methods

  def app
    Endpoints::Health
  end

  describe 'GET /health' do
    it 'returns a 200, correct headers and parseable json content' do
      get '/health'

      has_successful_response?
    end
  end

  describe 'GET /health/db' do
    it 'raises a 404 when no database is available' do
      allow(DB).to receive(:nil?).and_return(true)

      expect { get '/health/db' }. to raise_error(Pliny::Errors::NotFound)
    end

    it 'raises a 503 on Sequel exceptions' do
      allow(DB).to receive(:test_connection).and_raise(Sequel::Error)

      expect { get '/health/db' }.to raise_error(Pliny::Errors::ServiceUnavailable)
    end

    it 'raises a 503 when connection testing fails' do
      allow(DB).to receive(:test_connection).and_return(false)

      expect { get '/health/db' }.to raise_error(Pliny::Errors::ServiceUnavailable)
    end

    it 'returns a 200, correct headers and parseable json content' do
      allow(DB).to receive(:test_connection).and_return(true)

      get '/health/db'

      has_successful_response?
    end
  end

  def has_successful_response?
    expect(last_response.status).to eq 200
    expect(last_response.headers['Content-Type']).to eq 'application/json;charset=utf-8'
    expect(last_response.headers['Content-Type']).to eq 'application/json;charset=utf-8'
    expect(last_response.headers['Content-Length'].to_i).to eq 2
  end
end
