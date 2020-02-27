//
//  WeatherDailyViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherDailyViewModel: ObservableObject {
	
	static let summaryKey = "summary"
	static let iconKey = "icon"
	static let dataKey = "data"
	
	@Published var summary: String
	@Published var icon: String
	@Published var data: [WeatherDayViewModel]
	
	init(json: [String: Any]) throws {
		summary = try NetworkUtility.valueForKey(WeatherDailyViewModel.summaryKey, json: json)
		icon = try NetworkUtility.valueForKey(WeatherDailyViewModel.iconKey, json: json)
		
		var dayDatas = [WeatherDayViewModel]()
		let dayDataArray: [[String: Any]] = try NetworkUtility.valueForKey(WeatherDailyViewModel.dataKey, json: json)
		dayDataArray.forEach { (dayDataJson) in
			guard let dayData = try? WeatherDayViewModel(json: dayDataJson) else { return }
			
			dayDatas.append(dayData)
		}
		data = dayDatas
	}
	
	init(summary: String, icon: String, data: [WeatherDayViewModel]) {
		self.summary = summary
		self.icon = icon
		self.data = data
	}
	
}

// MARK: - Data Object
class WeatherDayViewModel: ObservableObject {
	
	static let timestampKey = "time"
	static let summaryKey = "summary"
	static let iconKey = "icon"
	static let precipProbabilityKey = "precipProbability"
	static let temperatureHighKey = "temperatureHigh"
	static let temperatureLowKey = "temperatureLow"
	static let windSpeedKey = "windSpeed"
	
	@Published var timestamp: Int
	@Published var summary: String
	@Published var icon: String
	@Published var precipProbability: Double
	@Published var temperatureHigh: Double
	@Published var temperatureLow: Double
	@Published var windSpeed: Double
	
	// Derived
	@Published var time: Date
	@Published var timeString: String
	
	init(json: [String: Any]) throws {
		let sureTimestamp:Int = try NetworkUtility.valueForKey(WeatherDayViewModel.timestampKey, json: json)
		timestamp = sureTimestamp
		summary = try NetworkUtility.valueForKey(WeatherDayViewModel.summaryKey, json: json)
		icon = try NetworkUtility.valueForKey(WeatherDayViewModel.iconKey, json: json)
		precipProbability = try NetworkUtility.valueForKey(WeatherDayViewModel.precipProbabilityKey, json: json)
		temperatureHigh = try NetworkUtility.valueForKey(WeatherDayViewModel.temperatureLowKey, json: json)
		temperatureLow = try NetworkUtility.valueForKey(WeatherDayViewModel.temperatureHighKey, json: json)
		windSpeed = try NetworkUtility.valueForKey(WeatherDayViewModel.windSpeedKey, json: json)
										
		let date = Date(timeIntervalSince1970: TimeInterval(sureTimestamp))
		time = date
		timeString = NetworkUtility.shared.dateOnlyFormatter.string(from: date)
	}
	
}
