//
//  WeatherService.swift
//  WeatherApp
//
//  Created by David Rico on 13/02/2016.
//  Copyright © 2016 David Rico. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

typealias WeatherServiceResult = ServiceResult<[Int : [WeatherForecast]], NSError>.t

enum WeatherServiceActivities {

    case WeatherInCity(String, WeatherServiceResult -> ())
}


struct WeatherService: Service {
    static var service = WeatherService()
    
    func run(activity: WeatherServiceActivities) {
        
        switch activity {
            
        case .WeatherInCity(let city, let completion):
            
            let requestParameters = ["q" : city, "mode": "json", "appid" : "44db6a862fba0b067b1930da0d769e98",
                "units" : "metric"]
            
            Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/forecast",
                parameters: requestParameters,
                encoding: .URL,
                headers: nil).responseJSON { response in
                    
                    switch response.result {
                        
                    case .Success:
                        var objects: [Int : [WeatherForecast]] = [:]
                        
                        if let value = response.result.value {
                            let json = JSON(value)
    
                            for (_, jsonChild):(String, JSON) in json["list"] {

                                //Extract day
                                let weatherForecast = WeatherForecast(jsonObject: jsonChild)
                                
                                if let date = weatherForecast.date {
                                    if var forecasts = objects[date.day] {
                                        forecasts.append(weatherForecast)
                                    } else {
                                        objects[date.day] = [weatherForecast]
                                    }
                                }
                            }
                        }

                        let result = WeatherServiceResult(value: objects)
                        completion(result)
                        
                    case .Failure(let error):
                        completion(WeatherServiceResult(error: error))
                    }
            }
        }
            
        
    }
}