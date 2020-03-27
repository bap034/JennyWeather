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
	
	@Published var searchCityName: String { didSet { didSetSearchCityName() } }
	@Published var cityLocationViewModels = [CityLocationViewModel]()
	@Published var isError: Bool = false
	@Published var isEmpty: Bool = false
	
	init(cityName: String, locationManager: LocationManager = LocationManager.shared) {
		self.searchCityName = cityName
		self.locationManager = locationManager
		self.locationManager.searchCompletionDelegate = self
	}
	
	private func didSetSearchCityName() {
		searchMKAddress(searchCityName)
	}

	private func getCityLocationVMs(results: [SearchCompletionResultDTO]) -> [CityLocationViewModel] {
		let cityLocationVMs = results.map { (resultDTO) -> CityLocationViewModel in
			let primaryText = resultDTO.primaryText
			let secondaryText = resultDTO.secondaryText
			let cityLocationVM = CityLocationViewModel(primaryText: primaryText, secondaryText: secondaryText)
			return cityLocationVM
		}
		return cityLocationVMs
	}
}

// MARK: - LocationManager Methods
extension SearchLocationViewModel {
	func searchAddress(_ addressString: String) {
		locationManager.searchAddress(addressString, success: { (placemarks) in
			let cityLocationVMs = placemarks.map { (placemarkDTO) -> CityLocationViewModel in
				let streetAddress = placemarkDTO.addressString
				let cityLocationVM = CityLocationViewModel(primaryText: streetAddress)
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
	
	func searchMKAddress(_ addressString: String) {
		locationManager.searchMKAddress(addressString)
	}
}

// MARK: - LocationManagerSearchCompletionDelegate
extension SearchLocationViewModel: LocationManagerSearchCompletionDelegate {
	func onSearchCompletion(results: [SearchCompletionResultDTO]) {
		let cityLocationVMs = self.getCityLocationVMs(results: results)
		self.cityLocationViewModels = cityLocationVMs
		
		self.isError = false
		self.isEmpty = cityLocationVMs.isEmpty
	}
}
