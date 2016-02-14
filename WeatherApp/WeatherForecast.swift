//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by David Rico on 13/02/2016.
//  Copyright © 2016 David Rico. All rights reserved.
//

import Foundation

import SwiftyJSON
import SwiftDate

typealias Temperature = (current: Float,min: Float,max: Float)

enum WeekDay: String {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
    
    init(day: Int) {
        switch day {
            case 1: self = .Sunday
            case 2: self = .Monday
            case 3: self = .Tuesday
            case 4: self = .Wednesday
            case 5: self = .Thursday
            case 6: self = .Friday
            case 7: self = .Saturday
            default: self = .Monday
        }
    }
}

struct WeatherForecast {
    let temperature: Temperature
    let date: NSDate?
    let weekDay: WeekDay?
    
    init(jsonObject: JSON) {
    
        let dateString = jsonObject["dt_txt"].stringValue
        
        date = dateString.toDate(DateFormat.Custom("yyyy-MM-dd HH:mm:ss"))
        weekDay = WeekDay(day: (date?.weekday)!)
        
        temperature.current = jsonObject["main","temp"].floatValue
        temperature.min = jsonObject["main","temp_min"].floatValue
        temperature.max = jsonObject["main","temp_max"].floatValue
    }
}