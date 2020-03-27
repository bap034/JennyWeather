//
//  CityLocationViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/21/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class CityLocationViewModel: ObservableObject {
	
	@Published var primaryText: String
	@Published var secondaryText: String
	
	init(primaryText: String, secondaryText: String? = nil) {
		self.primaryText = primaryText
		self.secondaryText = secondaryText ?? ""
	}

}

extension CityLocationViewModel: Identifiable {
	var id: String { return UUID().uuidString }
}
