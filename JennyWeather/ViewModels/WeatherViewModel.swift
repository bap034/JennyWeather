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
		let alertJsons:[[String: Any]]? = NetworkUtility.valueOptionalForKey(WeatherViewModel.alertsKey, json: json)
		alertJsons?.forEach { (alertJson) in
			guard let sureAlertViewModel = try? WeatherAlertViewModel(json: alertJson) else { return }
			
			alertViewModelsFromJson.append(sureAlertViewModel)
		}
		
		let minutelyJson:[String: Any] = try NetworkUtility.valueForKey(WeatherViewModel.minutelyKey, json: json)
		let hourlyJson:[String: Any] = try NetworkUtility.valueForKey(WeatherViewModel.hourlyKey, json: json)
		let dailyJson:[String: Any] = try NetworkUtility.valueForKey(WeatherViewModel.dailyKey, json: json)
		let currentlyJson:[String: Any] = try NetworkUtility.valueForKey(WeatherViewModel.currentlyKey, json: json)
		
		alertViewModels = alertViewModelsFromJson
		minutelyViewModel = try WeatherMinutelyViewModel(json: minutelyJson)
		hourlyViewModel = try WeatherHourlyViewModel(json: hourlyJson)
		dailyViewModel = try WeatherDailyViewModel(json: dailyJson)
		currentlyViewModel = try WeatherCurrentlyViewModel(json: currentlyJson)
	}
	
}
