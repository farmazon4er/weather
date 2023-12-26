module Acme
  class Weather < Grape::API
    resource :weather do
      desc 'Current temp'
      get :current do
        temp = Temperature.current.last
        {temperature: temp.temperature}
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
        get  do
          {temperatures: Temperature.historical.last(25).pluck(:temperature)}
        end

        desc 'Historical max'
        get :max do
          {temperature: Temperature.historical.last(25).pluck(:temperature).max }
        end

        desc 'Historical min'
        get :min do
          {temperature: Temperature.historical.last(25).pluck(:temperature).min }
        end

        desc 'Historical average'
        get :avg do
          ar = Temperature.historical.last(25).pluck(:temperature)
          temperature = (ar.sum/ar.size).round(1)
          {temperature:  temperature}
        end
      end
    end
  end
end