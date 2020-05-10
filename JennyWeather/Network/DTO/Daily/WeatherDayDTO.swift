//
//  WeatherDayDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 5/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

struct WeatherDayDTO: Codable {
	
	var timestamp: Int
	var summary: String
	var icon: String
	var precipProbability: Double
	var temperatureHigh: Double
	var temperatureLow: Double
	var windSpeed: Double
	
	// Derived
	var time: Date
	
    enum CodingKeys: String, CodingKey {
		case timestamp = "time"
		case summary
		case icon
		case precipProbability
		case temperatureHigh
		case temperatureLow
		case windSpeed
    }
}

// MARK: - Manual Decoding
extension WeatherDayDTO {
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		timestamp = try values.decode(Int.self, forKey: .timestamp)
		summary = try values.decode(String.self, forKey: .summary)
		icon = try values.decode(String.self, forKey: .icon)
		precipProbability = try values.decode(Double.self, forKey: .precipProbability)
		temperatureHigh = try values.decode(Double.self, forKey: .temperatureHigh)
		temperatureLow = try values.decode(Double.self, forKey: .temperatureLow)
		windSpeed = try values.decode(Double.self, forKey: .windSpeed)
		
		let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
		time = date
	}
}

// MARK: - Identifiable
extension WeatherDayDTO: Identifiable {
	var id: Int { return timestamp }
}
