//
//  WeatherViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherViewModel: ObservableObject {
	
	static let alertsKey = "alerts"
	static let minutelyKey = "minutely"
	static let hourlyKey = "hourly"
	static let dailyKey = "daily"
	static let currentlyKey = "currently"
	
	@Published var alertViewModels: [WeatherAlertViewModel]
	@Published var minutelyViewModel: WeatherMinutelyViewModel
	@Published var hourlyViewModel: WeatherHourlyViewModel
	@Published var dailyViewModel: WeatherDailyViewModel
	@Published var currentlyViewModel: WeatherCurrentlyViewModel
	
	init(json: [String: Any]) throws {
		var alertViewModelsFromJson = [WeatherAlertViewModel]()
		let alertJsons:[[String: Any]] = try NetworkUtility.valueForKey(WeatherViewModel.alertsKey, json: json)
		alertJsons.forEach { (alertJson) in
			guard let sureAlertViewModel = try? WeatherAlertViewModel(json: alertJson) else { return }
			
			alertViewModelsFromJson.append(sureAlertViewModel)
		}
		
		alertViewModels = alertViewModelsFromJson
		minutelyViewModel = try WeatherMinutelyViewModel(json: json)
		hourlyViewModel = try WeatherHourlyViewModel(json: json)
		dailyViewModel = try WeatherDailyViewModel(json: json)
		currentlyViewModel = try WeatherCurrentlyViewModel(json: json)
	}
	
}




//func updateJsonString() {
//	let higbyLatitude = 37.8267
//	let higbyLongitude = -122.28
//	let dataService = WeatherDataService()
//	dataService.getWeatherData(latitude: higbyLatitude, longitude: higbyLongitude, success: { (json) in
//		if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
//			let string = String(data: data, encoding: .utf8) {
//
//			var dayViewModel: WeatherDailyViewModel?
//			if let firstDailyJson = (json["daily"] as? [[String: Any]])?.first {
//				dayViewModel = try? WeatherDailyViewModel(json: firstDailyJson)
//			}
//
//			DispatchQueue.main.async {
//				self.text = string
//				self.dayViewModel = dayViewModel
//			}
//		}
//	}, failure: { (error) in
//		print("error: \(error.debugDescription)")
//	})
//}
