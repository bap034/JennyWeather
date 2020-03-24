//
//  CityLocationViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/21/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class CityLocationViewModel: ObservableObject {
	
	@Published var streetAddress: String
	
	init(streetAddress: String) {
		self.streetAddress = streetAddress
	}

}

extension CityLocationViewModel: Identifiable {
	var id: String { return UUID().uuidString }
}
