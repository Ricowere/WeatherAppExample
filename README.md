# Weather App

A basic weather application coded in swift to make an small proof of concept of how to tackled common problems and challenges in this new language.

The app will cover a basic *use case*: Getting the 5-day forecast for a desired city from openweathermap.org

# Architecture

The architecture chosen is MVP with an small SOA based service to provide the forecasts from the remote server.

# Components

- WeatherInCityInteractor: It will have the responsibility of connect the WeatherService with the presenter to assure the use case required.

- WeatherService: It will be the layer responsible to interact with the remote server. (WeatherInCityActivity)

# Caveats and pitfalls

- As an proof of concept may I drop and reduce some responsibilities that could be split in other classes to reduce the complexity of the App.

