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
		return UserDefaults.standard.integer(forKey: FunManager.candiceSpecialCounterKey)
	}
	private func setCandiceSpecialValue(_ newValue: Int) {
		UserDefaults.standard.set(newValue, forKey: FunManager.candiceSpecialCounterKey)
	}
	
	func updateCandiceSpecialValue(_ currentTemperature: Double) {
		let candiceSpecialValue = FunManager.shared.candiceSpecialValue
		if Int(currentTemperature.rounded()) == FunManager.candiceSpecialTarget {
			let newValue = candiceSpecialValue + 1
			FunManager.shared.setCandiceSpecialValue(newValue)
		}
	}
}
