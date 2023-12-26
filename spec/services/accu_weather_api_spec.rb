require 'spec_helper'

RSpec.describe AccuWeatherAPI, type: :service do
  context 'current' do
    subject { described_class.new.current }

    it 'create current temperature' do
      VCR.use_cassette('current_weather', record: :once) do
        expect { subject }.to change(Temperature.current, :count).by(1)

        temperature = Temperature.current.last
        expect(temperature.temperature).to eq(-5.6)
        expect(temperature.epoch_time).to eq(1703598720)
        expect(temperature.current).to eq(true)
      end
    end
  end

  context 'historical' do
    subject { described_class.new.historical }

    it 'create historical temperature' do
      VCR.use_cassette('historical_weather', record: :once) do
        expect { subject }.to change(Temperature.historical, :count).by(24)
      end
    end
  end
end