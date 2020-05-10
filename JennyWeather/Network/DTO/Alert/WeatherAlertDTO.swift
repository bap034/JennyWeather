//
//  WeatherAlertDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 5/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

struct WeatherAlertDTO: Codable {
	
	var title: String
		var timestamp: Int
		var expiresTimestamp: Int
		var description: String
		var uri: String
		
		// Derived
		var time: Date
		var expiresTime: Date
		
		enum CodingKeys: String, CodingKey {
			case title
			case timestamp = "time"
			case expiresTimestamp = "expires"
			case description
			case uri
		}
	}

	// MARK: - Manual Decoding
	extension WeatherAlertDTO {
		init(from decoder: Decoder) throws {
			let values = try decoder.container(keyedBy: CodingKeys.self)
			title = try values.decode(String.self, forKey: .title)
			timestamp = try values.decode(Int.self, forKey: .timestamp)
			expiresTimestamp = try values.decode(Int.self, forKey: .expiresTimestamp)
			description = try values.decode(String.self, forKey: .description)
			uri = try values.decode(String.self, forKey: .uri)
			
			let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
			time = date
			
			let expiresDate = Date(timeIntervalSince1970: TimeInterval(expiresTimestamp))
			expiresTime = expiresDate
		}
	}
