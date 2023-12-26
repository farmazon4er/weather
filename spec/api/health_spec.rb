require 'spec_helper'

describe Acme::Health do
  it 'health check' do
    get '/api/health'
    expect(response.body).to eq({ status: 'ok' }.to_json)
  end
  it 'ping with a parameter' do
    get '/api/health?pong=test'
    expect(response.body).to eq({ status: 'ok' }.to_json)
  end
end
