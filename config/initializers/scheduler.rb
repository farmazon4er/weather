require 'rufus-scheduler'
scheduler = Rufus::Scheduler.new

def acuuweatherapi
  AccuWeatherAPI.new
end

scheduler.every '15m' do
  acuuweatherapi.delay.current
end

scheduler.every '30m' do
  acuuweatherapi.delay.historical
end
