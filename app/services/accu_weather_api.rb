class AccuWeatherAPI
  URL = "http://dataservice.accuweather.com"
  attr_reader :api_key, :city_key

  def initialize
    @api_key = ENV["API_KEY"]
    @city_key = ENV["CITY_KEY"]
  end

  def connection
    Faraday.new(
      url: URL,
      headers: {'Accept' => '*/*', 'Content-Type' => 'application/json'}
    )
  end

  def current_temp
    responce = JSON.parse(connection.get("currentconditions/v1/#{city_key}", {apikey: api_key}))
    temp = responce[0]["Temperature"]["Metric"]["Value"]
  end
end