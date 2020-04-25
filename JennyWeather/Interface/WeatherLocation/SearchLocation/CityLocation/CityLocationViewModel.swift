//
//  CityLocationViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/21/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class CityLocationViewModel: ObservableObject {
	
	@Published var primaryString: String
	@Published var secondaryString: String
	
	init(primaryString: String, secondaryString: String? = nil) {
		self.primaryString = primaryString
		self.secondaryString = secondaryString ?? ""
	}
}

// MARK: - Helper Methods
extension CityLocationViewModel {
	var combinedString: String {
		var newString = primaryString
		if !secondaryString.isEmpty {
			newString += ", " + secondaryString
		}
		return newString
	}
}

// MARK: - Identifiable
extension CityLocationViewModel: Identifiable {
	var id: String { return primaryString }
}
