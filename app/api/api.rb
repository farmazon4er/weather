class API < Grape::API
  prefix 'api'
  format :json
  mount Acme::Health
  mount Acme::Weather
  add_swagger_documentation info: { title: 'grape-on-rails' }
end
