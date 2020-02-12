//
//  WeatherDayViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherDayViewModel: ObservableObject {
	
	static let summaryKey = "summary"
	static let iconKey = "icon"
	static let dataKey = "data"
	
	@Published var summary: String
	@Published var icon: String
	@Published var data: [WeatherDayDataViewModel]
	
	init(json: [String: Any]) throws {
		summary = try NetworkUtility.valueForKey(WeatherDayViewModel.summaryKey, json: json)
		icon = try NetworkUtility.valueForKey(WeatherDayViewModel.iconKey, json: json)
		
		var dayDatas = [WeatherDayDataViewModel]()
		let dayDataArray: [[String: Any]] = try NetworkUtility.valueForKey(WeatherDayViewModel.dataKey, json: json)
		dayDataArray.forEach { (dayDataJson) in
			guard let dayData = try? WeatherDayDataViewModel(json: dayDataJson) else { return }
			
			dayDatas.append(dayData)
		}
		data = dayDatas
	}
	
	init(summary: String, icon: String, data: [WeatherDayDataViewModel]) {
		self.summary = summary
		self.icon = icon
		self.data = data
	}
	
}

// MARK: - Data Object
class WeatherDayDataViewModel: ObservableObject {
	
	static let timestampKey = "time"
	static let summaryKey = "summary"
	static let iconKey = "icon"
	static let precipProbabilityKey = "precipProbability"
	static let temperatureHighKey = "temperatureHigh"
	static let temperatureLowKey = "temperatureLow"
	static let windSpeedKey = "windSpeed"
	
	@Published var timestamp: Int // Timestamp
	@Published var summary: String
	@Published var icon: String
	@Published var precipProbability: Double
	@Published var temperatureHigh: Double
	@Published var temperatureLow: Double
	@Published var windSpeed: Double
	
	// MARK: Derived
	@Published var time: Date
	
	init(json: [String: Any]) throws {
		let sureTimestamp:Int = try NetworkUtility.valueForKey(WeatherDayDataViewModel.timestampKey, json: json)
		timestamp = sureTimestamp
		summary = try NetworkUtility.valueForKey(WeatherDayDataViewModel.summaryKey, json: json)
		icon = try NetworkUtility.valueForKey(WeatherDayDataViewModel.iconKey, json: json)
		precipProbability = try NetworkUtility.valueForKey(WeatherDayDataViewModel.precipProbabilityKey, json: json)
		temperatureHigh = try NetworkUtility.valueForKey(WeatherDayDataViewModel.temperatureLowKey, json: json)
		temperatureLow = try NetworkUtility.valueForKey(WeatherDayDataViewModel.temperatureHighKey, json: json)
		windSpeed = try NetworkUtility.valueForKey(WeatherDayDataViewModel.windSpeedKey, json: json)
				
		time = Date(timeIntervalSince1970: TimeInterval(sureTimestamp))
	}
	
	init(timestamp: Int,
		 summary: String,
		 icon: String,
		 precipProbability: Double,
		 temperatureHigh: Double,
		 temperatureLow: Double,
		 windSpeed: Double) {
		self.timestamp = timestamp
		self.summary = summary
		self.icon = icon
		self.precipProbability = precipProbability
		self.temperatureHigh = temperatureHigh
		self.temperatureLow = temperatureLow
		self.windSpeed = windSpeed
		
		self.time = Date(timeIntervalSince1970: TimeInterval(timestamp))
	}
	
}
