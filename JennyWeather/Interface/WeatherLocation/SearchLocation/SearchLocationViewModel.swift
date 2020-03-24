//
//  SearchLocationViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/21/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class SearchLocationViewModel: ObservableObject  {

	let locationManager: LocationManager
	
	@Published var searchCityName: String
	@Published var cityLocationViewModels = [CityLocationViewModel]()
	@Published var isError: Bool = false
	@Published var isEmpty: Bool = false
	
	init(cityName: String, locationManager: LocationManager = LocationManager.shared) {
		self.searchCityName = cityName
		self.locationManager = locationManager
	}

}

// MARK: - LocationManager Methods
extension SearchLocationViewModel {
	func searchAddress(_ addressString: String) {
		locationManager.searchAddress(addressString, success: { (placemarks) in
			let cityLocationVMs = placemarks.map { (placemarkDTO) -> CityLocationViewModel in
				let streetAddress = placemarkDTO.addressString
				let cityLocationVM = CityLocationViewModel(streetAddress: streetAddress)
				return cityLocationVM
			}
			
			self.cityLocationViewModels = cityLocationVMs
			self.isError = false
			self.isEmpty = cityLocationVMs.isEmpty
		}, failure: { (error) in
			if error.type == .noResults {
				self.isError = false
				self.isEmpty = true
			} else {
				self.isError = true
				self.isEmpty = true
			}
			
		})
	}
}
