//
//  WeatherViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherViewModel: ObservableObject {
	@Published var jsonString: String = "Loading..."
	
	func updateJsonString() {
		let higbyLatitude = 37.8267
		let higbyLongitude = -122.28
		let dataService = WeatherDataService()
		dataService.getWeatherData(latitude: higbyLatitude, longitude: higbyLongitude, success: { (json) in
//			print("success: \(json)")
			if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
				let string = String(data: data, encoding: .utf8) {
				DispatchQueue.main.async {
					self.jsonString = string					
				}
			}
		}, failure: { (error) in
			print("error: \(error.debugDescription)")
		})
	}
}
