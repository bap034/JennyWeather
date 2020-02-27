//
//  WeatherCurrentlyViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherCurrentlyViewModel: ObservableObject {
	
	static let timestampKey = "time"
	static let summaryKey = "summary"
	static let iconKey = "icon"
	static let precipProbabilityKey = "precipProbability"
	static let temperatureKey = "temperature"
	static let windSpeedKey = "windSpeed"
	
	@Published var timestamp: Int
	@Published var summary: String
	@Published var icon: String
	@Published var precipProbability: Double
	@Published var temperature: Double
	@Published var windSpeed: Double
	
	// Derived
	@Published var time: Date
	
	init(json: [String: Any]) throws {
		let sureTimestamp:Int = try NetworkUtility.valueForKey(WeatherCurrentlyViewModel.timestampKey, json: json)
		timestamp = sureTimestamp
		summary = try NetworkUtility.valueForKey(WeatherCurrentlyViewModel.summaryKey, json: json)
		icon = try NetworkUtility.valueForKey(WeatherCurrentlyViewModel.iconKey, json: json)
		precipProbability = try NetworkUtility.valueForKey(WeatherCurrentlyViewModel.precipProbabilityKey, json: json)
		temperature = try NetworkUtility.valueForKey(WeatherCurrentlyViewModel.temperatureKey, json: json)
		windSpeed = try NetworkUtility.valueForKey(WeatherCurrentlyViewModel.windSpeedKey, json: json)
				
		time = Date(timeIntervalSince1970: TimeInterval(sureTimestamp))
	}
	
}
