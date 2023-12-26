# weather api

A [Grape](http://github.com/ruby-grape/grape) API mounted on Rails.

- [health](app/api/acme/health.rb): check status `GET` API
- [weather](app/api/acme/weather.rb): temperature `GET` API

## Run

```
bin/setup
cp .env.exemple .env, add city and api key from[ https://www.accuweather.com/](https://developer.accuweather.com/)
rspec
rails s
rails jobs:work
```

- Try http://localhost:3000/api/health
- View Swagger docs at http://localhost:3000/swagger.
