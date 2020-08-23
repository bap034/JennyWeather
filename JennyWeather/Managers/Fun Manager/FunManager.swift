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
	private static let candiceSpecialCounterKey = "candiceSpecialCounterKey"
	
	var candiceSpecialValue: Int {
		return UserDefaults.standard.integer(forKey: FunManager.candiceSpecialCounterKey)
	}
	func setCandiceSpecialValue(_ newValue: Int) {
		UserDefaults.standard.set(newValue, forKey: FunManager.candiceSpecialCounterKey)
	}
}
