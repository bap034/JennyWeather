//
//  CloudKitManager.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/27/21.
//  Copyright © 2021 Brett Petersen. All rights reserved.
//

import Foundation
import CloudKit

struct Secret: Codable {
	let darkSkyAPI: String
}

class CloudKitManager {
	
	private static let publicDatabase = CKContainer.default().publicCloudDatabase
	private static let zoneId = CKRecordZone.default().zoneID
	private static let secretsRecordType = "Secrets"
	
	static func retrieveSecret(success: ((Secret)->Void)?, failure: (()->Void)?) {
		let predicate = NSPredicate(value: true)
		let query = CKQuery(recordType: secretsRecordType, predicate: predicate)
		publicDatabase.perform(query, inZoneWith: zoneId) { (records, error) in
			guard let sureRecord = records?.first else {
				print(">>> error: \(String(describing: error?.localizedDescription))")
				failure?()
				return
			}
			guard let secret: Secret = sureRecord.toCodable() else {
				failure?()
				return
			}
			
			success?(secret)
		}
	}
}

// MARK: - Utility Methods
extension CKRecord {
	func toJson() -> [String: Any] {
		var json = [String: Any]()
		
		allKeys().forEach { (key) in
			guard let sureValue = value(forKey: key) else { return }
			
			json[key] = sureValue
		}
		
		return json
	}
	
	func toCodable<T: Codable>() -> T? {
		let json = toJson()
		let codable: T? = try? NetworkUtility.codableFromJSON(json)
		return codable
	}
}
