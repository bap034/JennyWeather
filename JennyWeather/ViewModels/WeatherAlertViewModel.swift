//
//  WeatherAlertViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherAlertViewModel: ObservableObject {
	
	static let titleKey = "title"
	static let timestampKey = "time"
	static let expiresTimestampKey = "expires"
	static let descriptionKey = "description"
	static let uriKey = "uri"
	
	@Published var title: String
	@Published var timestamp: Int
	@Published var expiresTimestamp: Int
	@Published var description: String
	@Published var uri: String
	
	// Derived
	@Published var time: Date
	@Published var expiresTime: Date
	
	init(json: [String: Any]) throws {
		let sureTimestamp:Int = try NetworkUtility.valueForKey(WeatherAlertViewModel.timestampKey, json: json)
		let sureExpiresTimestamp:Int = try NetworkUtility.valueForKey(WeatherAlertViewModel.expiresTimestampKey, json: json)
		
		title = try NetworkUtility.valueForKey(WeatherAlertViewModel.titleKey, json: json)
		timestamp = sureTimestamp
		expiresTimestamp = sureExpiresTimestamp
		description = try NetworkUtility.valueForKey(WeatherAlertViewModel.descriptionKey, json: json)
		uri = try NetworkUtility.valueForKey(WeatherAlertViewModel.uriKey, json: json)
		
		time = Date(timeIntervalSince1970: TimeInterval(sureTimestamp))
		expiresTime = Date(timeIntervalSince1970: TimeInterval(sureExpiresTimestamp))
	}
	
}
