//
//  SearchLocationViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 3/21/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class SearchLocationViewModel: WeatherLocationViewModel {

	@Published var searchCityName: String
	
	@Published var cityLocationViewModels = [CityLocationViewModel]()
	
	override init(cityName: String, locationManager: LocationManager = LocationManager.shared) {
		self.searchCityName = cityName
		super.init(cityName: cityName)
	}

}
