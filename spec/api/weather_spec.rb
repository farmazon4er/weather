require 'spec_helper'

describe Acme::Weather do
  context 'current temp' do
    let!(:temperature) { create :temperature }
    it 'check current temp' do
      get '/api/weather/current'
      expect(response.body).to eq({ temperature: temperature.temperature }.to_json)
    end
  end

  context 'historical temp' do
    25.times do |i|
      let(:temperatures) { create :temperature, :historical, epoch_time: Time.current.to_i - i*60*60 }
    end
    hist = Temperature.historical.last(25).pluck(:temperature)

    it 'check historical temp' do
      get '/api/weather/historical'
      expect(response.body).to eq({ temperatures: hist }.to_json)
    end

    it 'check max temp' do
      get '/api/weather/historical/max'
      expect(response.body).to eq({ temperature: hist.max }.to_json)
    end

    it 'check min temp' do
      get '/api/weather/historical/min'
      expect(response.body).to eq({ temperature: hist.min }.to_json)
    end

    it 'check avg temp' do
      get '/api/weather/historical/avg'
      avg = (hist.sum/hist.size).round(1)
      expect(response.body).to eq({ temperature: avg }.to_json)
    end
  end

  context 'check by time' do
    let!(:temperature) { create :temperature, epoch_time:  Time.current.to_i - 10*60}

    it 'check by_time temp' do
      get "/api/weather/by_time/?timestamp=#{Time.current.to_i - 10*60}"
      expect(response.body).to eq({ temperature: temperature.temperature }.to_json)
    end

    context 'when not found' do
      it 'not found' do
        get "/api/weather/by_time/?timestamp=#{100}"
        expect(response.status).to eq(404)
        expect(response.body).to eq({ status: 404 }.to_json)
      end
    end
  end
end
