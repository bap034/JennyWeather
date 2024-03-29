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
	
	@Published var canPresentSearchLocation: Bool = false
	@Published var canPresentSettings: Bool = false
	
	@Published var cityName: String
	
	init(locationManager: LocationManager = LocationManager.shared) {
		self.cityName = locationManager.currentPlacemark.addressString
		
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
			canPresentSearchLocation = isLocationAuthorized
		}
	}
	
	func updateWeather() {
		
	}
}


// MARK: - LocationManagerAuthorizationDelegate
extension WeatherLocationViewModel: LocationManagerAuthorizationDelegate {
	func onSuccessfulAuthorization() {
		canPresentSearchLocation = true
	}

	func onFailureAuthorization() {
		canPresentSearchLocation = false
	}
}
