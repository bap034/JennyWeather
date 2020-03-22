//
//  LocationManager.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/21/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import CoreLocation
import Foundation

protocol LocationManagerDelegate {
	func onSuccessfulAuthorization()
	func onFailureAuthorization()
}

class LocationManager: NSObject {
	
	static let shared = LocationManager()

	private let clLocationManager = CLLocationManager()
	
	var delegate: LocationManagerDelegate?
	
	override init() {
		super.init()
		clLocationManager.delegate = self
	}
	
}

// MARK: - CLLocationManager Methods
extension LocationManager {
	var isLocationAuthorized: Bool {
		let isAuthorizedWhenInUse = CLLocationManager.authorizationStatus() == .authorizedWhenInUse
		let isAuthorizedAlways = CLLocationManager.authorizationStatus() == .authorizedAlways
		return isAuthorizedWhenInUse || isAuthorizedAlways
	}
	
	func requestWhenInUseAuthorization() {
		clLocationManager.requestWhenInUseAuthorization()
	}
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		guard manager == clLocationManager else { return }
		
		switch status {
		case .authorizedWhenInUse, .authorizedAlways:
			self.delegate?.onSuccessfulAuthorization()
		case .denied, .restricted, .notDetermined:
			self.delegate?.onFailureAuthorization()
		@unknown default:
			return
		}
	}
}
