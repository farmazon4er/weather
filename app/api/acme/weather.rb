module Acme
  class Weather < Grape::API
    helpers do
      def current_temp
        Rails.cache.fetch("current_temp", expires_in: 15.minutes) do
          Temperature.current.last.temperature
        end
      end

      def historical_temp
         Rails.cache.fetch("historical_temp", expires_in: 30.minutes) do
          Temperature.historical.last(25).pluck(:temperature)
        end
      end
    end

    resource :weather do
      desc 'Current temp'
      get :current do
        {temperature: current_temp}
      end

      desc 'Temp by time'
      params do
        requires :timestamp, type: Integer, desc: 'Timestamp'
      end
      get :by_time do
        temp = Temperature.order(Arel.sql("ABS(#{params[:timestamp].to_i} - epoch_time)")).first
        if (temp.epoch_time - params[:timestamp].to_i) < 30 * 60
          {temperature: temp.temperature}
        else
          status :not_found
          {status: 404}
        end
      end

      resource :historical do
        desc 'Historical temp 24 h'
        get do
          { temperatures: historical_temp }
        end

        desc 'Historical max'
        get :max do
          { temperature: historical_temp.max }
        end

        desc 'Historical min'
        get :min do
          { temperature: historical_temp.min }
        end

        desc 'Historical average'
        get :avg do
          temperature = (historical_temp.sum/historical_temp.size).round(1)
          { temperature:  temperature }
        end
      end
    end
  end
end