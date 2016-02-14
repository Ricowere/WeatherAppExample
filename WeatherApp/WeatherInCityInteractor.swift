//
//  WeatherInCityInteractor.swift
//  WeatherApp
//
//  Created by David Rico on 13/02/2016.
//  Copyright © 2016 David Rico. All rights reserved.
//

import Foundation

import Result

typealias WeatherInCityUseCaseResult = Result<(city: String, forecasts: [WeatherForecast]), WeatherInCityError>
typealias WeatherInCityError = NSError

struct WeatherInCityInteractor : UseCaseInteractor {
    let city: String
    
    var onFinished: (WeatherInCityUseCaseResult) -> ()
    
    func execute() {
        
        WeatherService.service.run(.WeatherInCity("London,us", { result in
            
            let mappedResult = result.map { forecastsDict -> (city: String, forecasts: [WeatherForecast]) in
                
                let sortedKeys = Array(forecastsDict.keys).sort()
                var forescastResult: [WeatherForecast] = []
                
                for key in sortedKeys {
                    if let forecast = forecastsDict[key]!.first {
                        forescastResult.append(forecast)
                    }
                }

                return (city: self.city, forecasts: forescastResult)
            }
            
            self.onFinished(mappedResult)
        }))
    }
}