//
//  WeatherViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherViewModel: ObservableObject {
	@Published var text: String = "Loading..."
	
	@Published var dayViewModel: WeatherDayViewModel?
	
	func updateJsonString() {
		let higbyLatitude = 37.8267
		let higbyLongitude = -122.28
		let dataService = WeatherDataService()
		dataService.getWeatherData(latitude: higbyLatitude, longitude: higbyLongitude, success: { (json) in
			if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
				let string = String(data: data, encoding: .utf8) {
				
				var dayViewModel: WeatherDayViewModel?
				if let firstDailyJson = (json["daily"] as? [[String: Any]])?.first {
					dayViewModel = try? WeatherDayViewModel(json: firstDailyJson)
				}
				
				DispatchQueue.main.async {
					self.text = string
					self.dayViewModel = dayViewModel
				}
			}
		}, failure: { (error) in
			print("error: \(error.debugDescription)")
		})
	}
}
