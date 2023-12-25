module Acme
  class Weather < Grape::API
    desc 'Current temp'
    get :current do
      { health: 'ok' }
    end
  end
end