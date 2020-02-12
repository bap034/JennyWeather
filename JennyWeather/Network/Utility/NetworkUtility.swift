//
//  NetworkUtility.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

// MARK: - Singletons
class NetworkUtility {
	static let shared = NetworkUtility()

	let dateFormatter: DateFormatter
	let timeOnlyFormatter: DateFormatter
	let dateOnlyFormatter: DateFormatter
	
	init() {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		dateFormatter.timeStyle = .short
		self.dateFormatter = dateFormatter
		
		let timeOnlyFormatter = DateFormatter()
		timeOnlyFormatter.dateStyle = .none
		timeOnlyFormatter.timeStyle = .short
		self.timeOnlyFormatter = timeOnlyFormatter
		
		let dateOnlyFormatter = DateFormatter()
		dateOnlyFormatter.dateStyle = .short
		dateOnlyFormatter.timeStyle = .none
		self.dateOnlyFormatter = dateOnlyFormatter
	}
	
}

// MARK: - Data Transfer Utility
extension NetworkUtility {
	static func valueForKey<T>(_ key: String, json: [String: Any]) throws -> T {
		guard let sureValue = json[key] else {
			throw JSONError(type: .keyNotFound, key: key, value: nil)
		}
		guard let value = sureValue as? T else {
			throw JSONError(type: .mismatchValueType, key: key, value: sureValue)
		}
		
		return value
	}
}
