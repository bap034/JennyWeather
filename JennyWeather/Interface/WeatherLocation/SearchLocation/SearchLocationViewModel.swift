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
	
	init(cityName: String, locationManager: LocationManager = LocationManager.shared) {
		self.searchCityName = cityName
		self.locationManager = locationManager
	}

}

// MARK: - LocationManager Methods
extension SearchLocationViewModel {
	func searchAddress(_ addressString: String) {
		cityLocationViewModels.removeAll()
		
		locationManager.searchAddress(addressString, success: { (placemarks) in
			let cityLocationVMs = placemarks.map { (placemarkDTO) -> CityLocationViewModel in
				let streetAddress = placemarkDTO.addressString
				let cityLocationVM = CityLocationViewModel(streetAddress: streetAddress)
				return cityLocationVM
			}
			
			/// Need to update the `@Published` variables on the `main` thread. Does not work to wrap the API call in a `DispatchQueue.main`.
			DispatchQueue.main.async {
				self.cityLocationViewModels = cityLocationVMs
			}
		}, failure: nil)
	}
}
