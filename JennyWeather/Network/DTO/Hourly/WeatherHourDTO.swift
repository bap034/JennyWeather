//
//  WeatherHourDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 5/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

struct WeatherHourDTO: Codable {
	
	var timestamp: Int
	var summary: String
	var icon: String
	var precipProbability: Double
	var temperature: Double
	var windSpeed: Double
	
	// Derived
	var time: Date
	
    enum CodingKeys: String, CodingKey {
		case timestamp = "time"
		case summary
		case icon
		case precipProbability
		case temperature
		case windSpeed
    }
}

// MARK: - Manual Decoding
extension WeatherHourDTO {
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		timestamp = try values.decode(Int.self, forKey: .timestamp)
		summary = try values.decode(String.self, forKey: .summary)
		icon = try values.decode(String.self, forKey: .icon)
		precipProbability = try values.decode(Double.self, forKey: .precipProbability)
		temperature = try values.decode(Double.self, forKey: .temperature)
		windSpeed = try values.decode(Double.self, forKey: .windSpeed)
		
		let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
		time = date
	}
}

// MARK: - Identifiable
extension WeatherHourDTO: Identifiable {
	var id: Int { return timestamp }
}
