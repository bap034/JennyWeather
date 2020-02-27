//
//  WeatherHourlyViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherHourlyViewModel: ObservableObject {
	
	static let summaryKey = "summary"
	static let iconKey = "icon"
	static let dataKey = "data"
	
	@Published var summary: String
	@Published var icon: String
	@Published var data: [WeatherHourViewModel]
	
	init(json: [String: Any]) throws {
		summary = try NetworkUtility.valueForKey(WeatherHourlyViewModel.summaryKey, json: json)
		icon = try NetworkUtility.valueForKey(WeatherHourlyViewModel.iconKey, json: json)
		
		var hourDatas = [WeatherHourViewModel]()
		let hourDataArray: [[String: Any]] = try NetworkUtility.valueForKey(WeatherHourlyViewModel.dataKey, json: json)
		hourDataArray.forEach { (hourDataJson) in
			guard let hourData = try? WeatherHourViewModel(json: hourDataJson) else { return }
			
			hourDatas.append(hourData)
		}
		/// DarkSky provides more than 24 hours worth of data.
		let truncatedDatas = hourDatas.prefix(upTo: 25)
		data = Array(truncatedDatas)
	}
	
}

// MARK: - Data Object
class WeatherHourViewModel: ObservableObject {
	
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
	@Published var timeString: String
	
	init(json: [String: Any]) throws {
		let sureTimestamp:Int = try NetworkUtility.valueForKey(WeatherHourViewModel.timestampKey, json: json)
		timestamp = sureTimestamp
		summary = try NetworkUtility.valueForKey(WeatherHourViewModel.summaryKey, json: json)
		icon = try NetworkUtility.valueForKey(WeatherHourViewModel.iconKey, json: json)
		precipProbability = try NetworkUtility.valueForKey(WeatherHourViewModel.precipProbabilityKey, json: json)
		temperature = try NetworkUtility.valueForKey(WeatherHourViewModel.temperatureKey, json: json)
		windSpeed = try NetworkUtility.valueForKey(WeatherHourViewModel.windSpeedKey, json: json)
				
		let date = Date(timeIntervalSince1970: TimeInterval(sureTimestamp))
		time = date
		timeString = NetworkUtility.shared.timeOnlyFormatter.string(from: date)
	}
	
}

// MARK: Identifiable
extension WeatherHourViewModel: Identifiable {
	var id: Int { return timestamp }
}
