//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by David Rico on 13/02/2016.
//  Copyright © 2016 David Rico. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let presenter = WeatherInCityPresenter()
        let rootViewController = WeatherInCityViewController(city: "London,uk",
            presenter: presenter)
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

