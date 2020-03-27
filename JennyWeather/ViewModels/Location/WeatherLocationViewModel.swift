//
//  WeatherLocationViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/1/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherLocationViewModel: NSObject, ObservableObject {
		
	let locationManager: LocationManager
	
	@Published var canPresent: Bool = false
	
	@Published var cityName: String
	
	init(cityName: String, locationManager: LocationManager = LocationManager.shared) {
		self.cityName = cityName
		
		self.locationManager = locationManager
		
		super.init()
		
		self.locationManager.authorizationDelegate = self
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


// MARK: - LocationManagerAuthorizationDelegate
extension WeatherLocationViewModel: LocationManagerAuthorizationDelegate {
	func onSuccessfulAuthorization() {
		canPresent = true
	}

	func onFailureAuthorization() {
		canPresent = false
	}
}
