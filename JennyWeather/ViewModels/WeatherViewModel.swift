//
//  WeatherViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherViewModel: ObservableObject {
	
	static var shared: WeatherViewModel?
	
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

// MARK: - Helper Methods
extension WeatherViewModel {
	var lastFetchedTime: Date {
		let time = currentlyViewModel.time
		return time
	}
	
	private func loadNewWeatherData(_ json: [String: Any]) {
		guard let sureNewWeatherViewModel = try? WeatherViewModel(json: json) else { return }
		
		self.alertViewModels = sureNewWeatherViewModel.alertViewModels
		self.minutelyViewModel = sureNewWeatherViewModel.minutelyViewModel
		self.hourlyViewModel = sureNewWeatherViewModel.hourlyViewModel
		self.dailyViewModel = sureNewWeatherViewModel.dailyViewModel
		self.currentlyViewModel = sureNewWeatherViewModel.currentlyViewModel
	}
	
	func updateWeatherData(success: (()->Void)?, failure: DataServiceFailure) {
		guard let sureLatitude = LocationManager.shared.currentPlacemark.latitude,
			let sureLongitude = LocationManager.shared.currentPlacemark.longitude else {
				failure?(nil)
				return
		}
		
		let dataService = WeatherDataService()
		dataService.getWeatherData(latitude: sureLatitude, longitude: sureLongitude, success: { (json) in
			/// Need to update the `@Published` variables on the `main` thread. Does not work to wrap the API call in a `DispatchQueue.main`.
			DispatchQueue.main.async {
				self.loadNewWeatherData(json)
				success?()
			}
		}, failure: { (error) in
			print("error: \(error.debugDescription)")
			failure?(error)
		})
	}
}
