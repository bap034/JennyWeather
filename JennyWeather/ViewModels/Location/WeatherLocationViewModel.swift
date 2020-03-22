//
//  WeatherLocationViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/1/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherLocationViewModel: NSObject, ObservableObject {
		
	static let shared = WeatherLocationViewModel(cityName: "Berkeley")
	
	private let locationManager: LocationManager
	
	@Published var canPresent: Bool = false
	
	@Published var latitude: Double
	@Published var longitude: Double
	@Published var cityName: String
	
	init(cityName: String, locationManager: LocationManager = LocationManager.shared) {
		self.cityName = cityName
		
		let coordinates = WeatherLocationViewModel.getCoordinates(cityName: cityName)
		self.latitude = coordinates.0
		self.longitude = coordinates.1
		
		self.locationManager = locationManager
		
		super.init()
		
		self.locationManager.delegate = self
	}
	
	/// Return: ( lattitude, longitude)
	private static func getCoordinates(cityName: String) -> (Double, Double) {
		let higbyLatitude = 37.851967
		let higbyLongitude = -122.286313
		return (higbyLatitude, higbyLongitude)
	}
}

// MARK: - View Exposed Methods
extension WeatherLocationViewModel {
	var isLocationAuthorized: Bool { return locationManager.isLocationAuthorized }
	
	func handlePresentingSearchLocationView() {
		if !isLocationAuthorized {
			locationManager.requestWhenInUseAuthorization()
		} else {
			canPresent = isLocationAuthorized
		}
	}
}


// MARK: - LocationManagerDelegate
extension WeatherLocationViewModel: LocationManagerDelegate {
	func onSuccessfulAuthorization() {
		canPresent = true
	}

	func onFailureAuthorization() {
		canPresent = false
	}
}
