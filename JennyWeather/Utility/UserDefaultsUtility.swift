//
//  UserDefaultsUtility.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/28/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class UserDefaultsUtility {
	
	private static let userDefaults = UserDefaults.standard
	
	private static func store<T: Codable>(codable: T, key: String) throws {
		let data = try JSONEncoder().encode(codable)
		userDefaults.set(data, forKey: key)
	}
	
	private static func retrieve<T: Codable>(key: String) -> T? {
		guard let data = userDefaults.data(forKey: key) else { return nil }
		
		let codable = try? JSONDecoder().decode(T.self, from: data)
		return codable
	}
}

// MARK: - Public Methods
// MARK: Current Placemark
extension UserDefaultsUtility {
	private static let currentPlacemarkKey = "currentPlacemark"
	
	static func storeCurrentPlacemark(_ placemark: PlacemarkDTO) {
		do {
			try store(codable: placemark, key: currentPlacemarkKey)
		} catch {
			print(">>>>>> failed to store current placemark")
		}
	}
	
	static var currentPlaceMark: PlacemarkDTO? {
		retrieve(key: currentPlacemarkKey)
	}
}

// MARK: Settings
extension UserDefaultsUtility {
	private static let isUsingMetricSystemKey = "isUsingMetricSystem"
	
	static func storeIsUsingMetricSystem(_ isUsing: Bool) {
		userDefaults.set(isUsing, forKey: isUsingMetricSystemKey)
	}
	
	static var isUsingMetricSystem: Bool {
		let isUsingMetricSystem = userDefaults.bool(forKey: isUsingMetricSystemKey)
		return isUsingMetricSystem
	}
}
