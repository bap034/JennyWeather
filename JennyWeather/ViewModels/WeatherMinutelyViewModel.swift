//
//  WeatherMinutelyViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherMinutelyViewModel: ObservableObject {
	
	static let summaryKey = "summary"
	
	@Published var summary: String?
	
	init(json: [String: Any]?) throws {
		guard let sureJson = json else { return }
		
		summary = try? NetworkUtility.valueForKey(WeatherMinutelyViewModel.summaryKey, json: sureJson)
	}
	
}
