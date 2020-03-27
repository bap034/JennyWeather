//
//  PlacemarkDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/22/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import CoreLocation
import Foundation

struct PlacemarkDTO: Codable {
	let name: String?		// name
	let street: String?		// subThoroughfare + thoroughfare
	let city: String?		// locality
	let state: String?		// administrativeArea
	let zipCode: String?	// postalCode
	
	let latitude: Double?
	let longitude: Double?
	
	init(placemark: CLPlacemark) {
		name = placemark.name
		
		var streetAddress: String?
		if let sureStreetNumber = placemark.subThoroughfare, let sureStreetName = placemark.thoroughfare {
			streetAddress = sureStreetNumber + " " + sureStreetName
		} else if let sureStreetName = placemark.thoroughfare {
			streetAddress = sureStreetName
		}
		street = streetAddress
		
		city = placemark.locality
		state = placemark.administrativeArea
		zipCode = placemark.postalCode
		
		latitude = placemark.location?.coordinate.latitude
		longitude = placemark.location?.coordinate.longitude
	}
	
	init(name: String? = nil,
		 street: String? = nil,
		 city: String? = nil,
		 state: String? = nil,
		 zipCode: String? = nil,
		 latitude: Double? = nil,
		 longitude: Double? = nil) {
		self.name = name
		self.street = street
		self.city = city
		self.state = state
		self.zipCode = zipCode
		self.latitude = latitude
		self.longitude = longitude
	}
}

// MARK: - Helper Methods
extension PlacemarkDTO {
	var addressString: String {
		var address = ""
		if let sureStreet = street, !sureStreet.isEmpty {
			address += sureStreet
		}
		if let sureCity = city, !sureCity.isEmpty {
			if !address.isEmpty {
				address += ", "
			}
			address += sureCity
		}
		if let sureState = state, !sureState.isEmpty {
			if !address.isEmpty {
				address += ", "
			}
			address += sureState
		}
		if let sureZipCode = zipCode, !sureZipCode.isEmpty {
			if !address.isEmpty {
				address += " "
			}
			address += sureZipCode
		}
		return address
	}
}
