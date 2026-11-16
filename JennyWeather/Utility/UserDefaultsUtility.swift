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
extension UserDefaultsUtility {
    // MARK: Current Placemark
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
    
    // MARK: Backup Fun Value
    private static let backupCandiceValueKey = "backupCandiceValueKey"
    static func storeBackupCandiceValue(_ value: Int) {
        do {
            try store(codable: value, key: backupCandiceValueKey)
        } catch {
            print(">>>>>> failed to store backup candice value key")
        }
    }
    static var backupCandiceValue: Int? {
        retrieve(key: backupCandiceValueKey)
    }
    
    // MARK: Backup Fun Value Last Updated
    private static let backupCandiceValueLastUpdatedKey = "backupCandiceValueLastUpdatedKey"
    static func storeBackupCandiceValueLastUpdated(_ value: TimeInterval) {
        do {
            try store(codable: value, key: backupCandiceValueLastUpdatedKey)
        } catch {
            print(">>>>>> failed to store backup candice value last updated key")
        }
    }
    static var backupCandiceValueLastUpdated: TimeInterval? {
        retrieve(key: backupCandiceValueLastUpdatedKey)
    }
}
