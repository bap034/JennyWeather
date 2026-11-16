//
//  FunManager.swift
//  JennyWeather
//
//  Created by Brett Petersen on 8/22/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class FunManager {
	
	static let shared = FunManager()
	
}

// MARK: - Candice Special Counter
extension FunManager {
    private var isIcloudAvailable: Bool { FileManager.default.ubiquityIdentityToken != nil }

    private static let candiceSpecialTarget = 69
    private static let candiceSpecialCounterKey = "candiceSpecialCounterKey"
    private static let candiceSpecialCounterLastUpdatedKey = "candiceSpecialCounterLastUpdatedKey"
    
    var candiceSpecialCounter: Int {
        var value: Int
        if isIcloudAvailable {
            value = Int(NSUbiquitousKeyValueStore.default.double(forKey: FunManager.candiceSpecialCounterKey))
        } else {
            value = UserDefaultsUtility.backupCandiceValue ?? 0
        }
        return value
    }
    private func setCandiceSpecialCounter(_ newValue: Int) {
        if isIcloudAvailable {
            NSUbiquitousKeyValueStore.default.set(newValue, forKey: FunManager.candiceSpecialCounterKey)
        } else {
            UserDefaultsUtility.storeBackupCandiceValue(newValue)
        }
    }
    var candiceSpecialCounterLastUpdated: TimeInterval {
        var lastUpdated: TimeInterval
        if isIcloudAvailable {
            let storedValue = NSUbiquitousKeyValueStore.default.double(forKey: FunManager.candiceSpecialCounterLastUpdatedKey)
            lastUpdated = TimeInterval(storedValue)
        } else {
            lastUpdated = UserDefaultsUtility.backupCandiceValueLastUpdated ?? 0.0
        }
        return lastUpdated
    }
    private func setCandiceSpecialCounterLastUpdated(_ newValue: TimeInterval) {
        if isIcloudAvailable {
            NSUbiquitousKeyValueStore.default.set(newValue, forKey: FunManager.candiceSpecialCounterLastUpdatedKey)
        } else {
            UserDefaultsUtility.storeBackupCandiceValueLastUpdated(newValue)
        }
    }
	
	func shouldIncrementCandiceSpecialValue(currentTemperature: Double) -> Bool {
		let isTargetValue = Int(currentTemperature.rounded()) == FunManager.candiceSpecialTarget
        let lastUpdatedDate = Date(timeIntervalSince1970: candiceSpecialCounterLastUpdated)
        let hasUpdatedToday = Calendar.current.isDateInToday(lastUpdatedDate)
        let shouldIncrement = isTargetValue && !hasUpdatedToday
		return shouldIncrement
	}
	func incrementCandiceSpecialValue() {
		let candiceSpecialValue = FunManager.shared.candiceSpecialCounter
		let newValue = candiceSpecialValue + 1
        FunManager.shared.setCandiceSpecialCounter(newValue)
        let todayTimeInterval = Date().timeIntervalSince1970
        FunManager.shared.setCandiceSpecialCounterLastUpdated(todayTimeInterval)
	}
}
