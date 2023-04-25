//
//  WeatherViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherViewModel: ObservableObject {
	
	static var shared: WeatherViewModel?
    
    let lastFetchedTime: Date
	
	@Published var locationVM: WeatherLocationViewModel
	@Published var alertViewModels: [WeatherAlertViewModel]
	@Published var hourlyViewModel: WeatherHourlyViewModel
	@Published var dailyViewModel: WeatherDailyViewModel
	@Published var currentlyViewModel: WeatherCurrentlyViewModel
	
	init(dto: WeatherDTO) {
        lastFetchedTime = dto.currently.time
        
		locationVM = WeatherLocationViewModel(locationManager: LocationManager.shared) // TODO: refactor to remove locationManager dependency
		
		var alertVMs = [WeatherAlertViewModel]()
		dto.alerts?.forEach { (alertDTO) in
			let alertViewModel = WeatherAlertViewModel(dto: alertDTO)
			alertVMs.append(alertViewModel)
		}
		alertViewModels = alertVMs

		hourlyViewModel = WeatherHourlyViewModel(dto: dto.hourly)
		dailyViewModel = WeatherDailyViewModel(dto: dto.daily)
		currentlyViewModel = WeatherCurrentlyViewModel(currentlyDTO: dto.currently, minutelyDTO: dto.minutely)
	}
	
}

// MARK: - Helper Methods
extension WeatherViewModel {
	var candiceSpecialValue: Int {
		let candiceSpecial = FunManager.shared.candiceSpecialValue
		return candiceSpecial
	}
	
	private func loadNewWeatherData(_ dto: WeatherDTO) {
		let cityName = LocationManager.shared.currentPlacemark.addressString
		let newWeatherViewModel = WeatherViewModel(dto: dto)
		
		self.locationVM.cityName = cityName
		
		self.alertViewModels = newWeatherViewModel.alertViewModels
		self.hourlyViewModel = newWeatherViewModel.hourlyViewModel
		self.dailyViewModel = newWeatherViewModel.dailyViewModel
		self.currentlyViewModel = newWeatherViewModel.currentlyViewModel
	}
	
	func updateWeatherData(success: (()->Void)?, failure: DataServiceFailure) {
		guard let sureLatitude = LocationManager.shared.currentPlacemark.latitude,
			let sureLongitude = LocationManager.shared.currentPlacemark.longitude else {
				failure?(nil)
				return
		}
		
		let dataService = WeatherDataService()
		dataService.getWeatherData(latitude: sureLatitude, longitude: sureLongitude, success: { (json) in
			/// Need to update the `@Published` variables on the `main` thread. Does not work to wrap the API call in a `DispatchQueue.main`.
			DispatchQueue.main.async {
				self.loadNewWeatherData(json)
				success?()
			}
		}, failure: { (error) in
			print("error: \(error.debugDescription)")
			failure?(error)
		})
	}
}
