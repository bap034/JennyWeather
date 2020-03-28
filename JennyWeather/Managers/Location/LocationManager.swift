//
//  LocationManager.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/21/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation
import MapKit

protocol LocationManagerAuthorizationDelegate {
	func onSuccessfulAuthorization()
	func onFailureAuthorization()
}
protocol LocationManagerSearchCompletionDelegate {
	func onSearchCompletion(results: [SearchCompletionResultDTO])
}

class LocationManager: NSObject {
	
	static let shared = LocationManager()

	private let clLocationManager = CLLocationManager()
	private let mkSearchCompleter = MKLocalSearchCompleter()
	
	var authorizationDelegate: LocationManagerAuthorizationDelegate?
	var searchCompletionDelegate: LocationManagerSearchCompletionDelegate?
	
	override init() {
		super.init()
		clLocationManager.delegate = self
		mkSearchCompleter.delegate = self
		mkSearchCompleter.resultTypes = .address
	}
	
}

// MARK: - Storing & Retrieving Current Placemark
extension LocationManager {
	// MARK: Storing
	func saveAsCurrentPlacemark(_ placemark: PlacemarkDTO) {
		UserDefaultsUtility.storeCurrentPlacemark(placemark)
	}
	
	// MARK: Retrieving
	var currentPlacemark: PlacemarkDTO {
		let storedPlacemark = UserDefaultsUtility.currentPlaceMark ?? LocationManager.defaultPlacemarkDTO
		return storedPlacemark
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
	
	func searchAddress(_ addressString: String, success: @escaping ([PlacemarkDTO])->Void, failure: ((LocationError)->Void)?) {
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString(addressString) { (placemarks, error) in
			guard error == nil else {
				let locationError: LocationError
				if let clError = (error as? CLError), clError.code == CLError.geocodeFoundNoResult {
					locationError = LocationError(type: .noResults)
				} else {
					locationError = LocationError(type: .other)
				}
				failure?(locationError)
				return
			}
			
			let placemarkResults = placemarks ?? [CLPlacemark]()
			var placemarkDTOs = [PlacemarkDTO]()
			placemarkResults.forEach { (placemark) in
				let placemarkDTO = PlacemarkDTO(placemark: placemark)
				placemarkDTOs.append(placemarkDTO)
			}
			success(placemarkDTOs)
		}
	}
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		guard manager == clLocationManager else { return }
		
		switch status {
		case .authorizedWhenInUse, .authorizedAlways:
			self.authorizationDelegate?.onSuccessfulAuthorization()
		case .denied, .restricted, .notDetermined:
			self.authorizationDelegate?.onFailureAuthorization()
		@unknown default:
			return
		}
	}
}

// MARK: - Default Data
extension LocationManager {
	static var defaultPlacemarkDTO: PlacemarkDTO {
		let placemarkDTO = PlacemarkDTO(city: "Berkeley", latitude: 37.8267, longitude: -122.28)
		return placemarkDTO
	}
}

// MARK: - MapKit
extension LocationManager: MKLocalSearchCompleterDelegate {
	func searchMKAddress(_ addressString: String) {
		mkSearchCompleter.queryFragment = addressString
	}
	
	func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
		var newResultDTOs = [SearchCompletionResultDTO]()
		
		let results = completer.results
		results.forEach { (result) in
			
			let primaryString = result.title
			var secondaryString: String? = nil
			if !result.subtitle.isEmpty {
				secondaryString = result.subtitle
			}
			let resultDTO = SearchCompletionResultDTO(primaryString: primaryString, secondaryString: secondaryString)
			newResultDTOs.append(resultDTO)
		}
		
		searchCompletionDelegate?.onSearchCompletion(results: newResultDTOs)
	}
}
