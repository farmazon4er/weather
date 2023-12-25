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

  def current
    responce = connection.get("currentconditions/v1/#{city_key}", {apikey: api_key})
    responce_json = JSON.parse(responce.body)
    temperature = responce_json[0]["Temperature"]["Metric"]["Value"]
    epoch_time = responce_json[0]["EpochTime"]

    Temperature.create!(temperature:, epoch_time:)
  end

  def historical
    responce = connection.get("currentconditions/v1/#{city_key}/historical/24", {apikey: api_key})
    responce_json = JSON.parse(responce.body)
    attributes = []
    responce_json.each{|r| attributes << {temperature: r["Temperature"]["Metric"]["Value"], epoch_time: r["EpochTime"]} }
    Temperature.insert_all(attributes)
  end
end