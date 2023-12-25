module Acme
  class Health < Grape::API
    desc 'Returns health status'
    get :health do
      { health: 'ok' }
    end
  end
end
