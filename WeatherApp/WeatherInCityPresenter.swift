//
//  WeatherInCityPresenter.swift
//  WeatherApp
//
//  Created by David Rico on 13/02/2016.
//  Copyright © 2016 David Rico. All rights reserved.
//

import Foundation

protocol WeatherInCityPresenterDeclaration {
    weak var UI: WeatherInCityView? { set get }
    var city: String { get }
    
    func loadWeather()
    
    func todayWeekDay() -> String
    func todayTemp() -> Float
    
    func weekDaysToDisplay() -> Int
    func presentWeekDayView(weekDayView: WeatherWeekdayTempView, atIndex: Int)
}

final class WeatherInCityPresenter: WeatherInCityPresenterDeclaration {
    weak var UI: WeatherInCityView?
    
    var city: String = ""
    var forecasts: [WeatherForecast] = []
    var todayForecast: WeatherForecast!
    
    func loadWeather() {
        
        let interactor = WeatherInCityInteractor(city: "London", onFinished: { result in
            
            switch result {
                case .Success:
                    let forecastTuple = result.value
                    
                    var forecasts = forecastTuple!.forecasts
                    if let first = forecasts.first {
                        self.todayForecast = first
                    
                        forecasts.removeFirst()
                        
                        //UI Presentation
                        self.UI?.todayTemp = String(self.todayForecast.temperature.current)
                        self.UI?.today = (self.todayForecast.weekDay?.rawValue)!
                    }
                    self.forecasts = forecasts
                    
                    //UI Presentation
                    self.UI?.cityViewReloadWeekDaysForecast()
                
                case .Failure: break
            }
        })
        
        interactor.execute()
    }
    
    func presentWeekDayView(weekDayView: WeatherWeekdayTempView, atIndex: Int) {
        let forecast = forecasts[atIndex]
        
        weekDayView.dayWeek = (forecast.weekDay?.rawValue)!
        weekDayView.currentTemp = String(forecast.temperature.current)
        weekDayView.minTemp = String(forecast.temperature.min)
        weekDayView.maxTemp = String(forecast.temperature.max)
    }
    
    func weekDaysToDisplay() -> Int {
        return forecasts.count
    }
    
    func todayWeekDay() -> String {
        return (self.todayForecast.weekDay?.rawValue)!
    }
    
    func todayTemp() -> Float {
        return todayForecast.temperature.current
    }
}