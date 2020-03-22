//
//  CityLocationViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/21/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class CityLocationViewModel: ObservableObject, Identifiable {

	@Published var streetAddress: String
	
	init(streetAddress: String) {
		self.streetAddress = streetAddress
	}

}
