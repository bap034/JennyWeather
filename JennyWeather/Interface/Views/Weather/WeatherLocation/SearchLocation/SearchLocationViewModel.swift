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
			let primaryString = resultDTO.primaryString
			let secondaryString = resultDTO.secondaryString
			let cityLocationVM = CityLocationViewModel(primaryString: primaryString, secondaryString: secondaryString)
			return cityLocationVM
		}
		return cityLocationVMs
	}
}

// MARK: - LocationManager Methods
extension SearchLocationViewModel {
	func select(_ addressString: String) {
		locationManager.searchAddress(addressString, success: { (placemarks) in
			/// Assuming the first is the closest match
			guard let placemark = placemarks.first else { return }
			
			self.locationManager.saveAsCurrentPlacemark(placemark)
            Task {
                await WeatherViewModel.shared?.updateWeatherData()
            }
		}, failure: { (error) in
			if error.type == .noResults {
				print("****** no results for selected address!")
			} else {
				print("****** something went wrong when selecting!")
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
