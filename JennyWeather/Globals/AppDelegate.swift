//
//  AppDelegate.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let higbyLatitude = 37.8267
		let higbyLongitude = -122.28
		let dataService = WeatherDataService()
		dataService.getWeatherData(latitude: higbyLatitude, longitude: higbyLongitude, success: { (data) in
			print("success: \(String(describing: data))")
		}, failure: { (error) in
			print("error: \(error.debugDescription)")
		})
		return true
	}

}

