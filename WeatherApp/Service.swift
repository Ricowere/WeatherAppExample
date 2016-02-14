//
//  Service.swift
//  WeatherApp
//
//  Created by David Rico on 13/02/2016.
//  Copyright © 2016 David Rico. All rights reserved.
//

import Foundation

import Result

// TO-DO: As soon as https://github.com/antitypical/Result/issues/77 is resolved, this file should be removed
struct ServiceResult<T, Error : ErrorType> {
    typealias t = Result<T, Error>
}

protocol Service {
    typealias Activities
    
    static var service: Self { get }
    
    func run(activity: Activities)
}

