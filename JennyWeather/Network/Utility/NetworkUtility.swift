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
	
	private init() {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
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
	static func valueForKey<T>(_ key: String, json: [String: Any], file: String = #file) throws -> T {
		let fileName: String = (file as NSString).lastPathComponent
		guard let sureValue = json[key] else {
			let error = JSONError(type: .keyNotFound, key: key, value: nil)
			print("\(fileName)" + " -- " + "\(error)")
			throw error
		}
		guard let value = sureValue as? T else {
			let error = JSONError(type: .mismatchValueType, key: key, value: sureValue)
			let description = "\(fileName) -- " + error.localizedDescription + " expected type: \(T.self)"
			print(description)
			throw error
		}
		
		return value
	}
	
	static func valueOptionalForKey<T>(_ key: String, json: [String: Any]) -> T? {
		let value = json[key] as? T
		return value
	}
}
