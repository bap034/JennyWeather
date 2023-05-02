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
    @Published var errorMessage: String?
    
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
	func handlePresentingSearchLocationView() {
        canPresentSearchLocation = true
        
        /// Note:  Only need Location Permission if retrieving the user's location. Not if searching a location.
//        switch locationManager.locationAuthorizationType {
//            case .authorized:
//                canPresentSearchLocation = true
//            case .denied:
//                errorMessage = "You must enable Location Permissions to search a location."
//            case .notDetermined:
//                locationManager.requestWhenInUseAuthorization()
//        }
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
