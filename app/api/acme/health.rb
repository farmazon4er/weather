module Acme
  class Health < Grape::API
    desc 'Returns health status'
    get :health do
      { status: 'ok' }
    end
  end
end
