//
//  WeatherLocationViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/1/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherLocationViewModel: ObservableObject {
	
//	var latitude: Double
//	var longitude: Double
	
	@Published var city: String
	
	init(city: String) {
		self.city = city
	}
	
}
