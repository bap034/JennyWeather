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
	private static let candiceSpecialTarget = 69
	private static let candiceSpecialCounterKey = "candiceSpecialCounterKey"
	
	var candiceSpecialValue: Int {
		let value = Int(NSUbiquitousKeyValueStore.default.double(forKey: FunManager.candiceSpecialCounterKey))
		return value
	}
	private func setCandiceSpecialValue(_ newValue: Int) {
		NSUbiquitousKeyValueStore.default.set(newValue, forKey: FunManager.candiceSpecialCounterKey)
	}
	
	func shouldIncrementCandiceSpecialValue(currentTemperature: Double) -> Bool {
		let shouldIncrement = Int(currentTemperature.rounded()) == FunManager.candiceSpecialTarget
		return shouldIncrement
	}
	func incrementCandiceSpecialValue() {
		let candiceSpecialValue = FunManager.shared.candiceSpecialValue
		let newValue = candiceSpecialValue + 1
		FunManager.shared.setCandiceSpecialValue(newValue)
	}
}
