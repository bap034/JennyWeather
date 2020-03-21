//
//  WeatherLocationViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/1/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherLocationViewModel: ObservableObject {
		
	static let shared = WeatherLocationViewModel(cityName: "Berkeley")
	
	@Published var latitude: Double
	@Published var longitude: Double
	@Published var cityName: String
	
	init(cityName: String) {
		self.cityName = cityName
		
		let coordinates = WeatherLocationViewModel.getCoordinates(cityName: cityName)
		self.latitude = coordinates.0
		self.longitude = coordinates.1
	}
	
	/// Return: ( lattitude, longitude)
	private static func getCoordinates(cityName: String) -> (Double, Double) {
		let higbyLatitude = 37.851967
		let higbyLongitude = -122.286313
		return (higbyLatitude, higbyLongitude)
	}
}
