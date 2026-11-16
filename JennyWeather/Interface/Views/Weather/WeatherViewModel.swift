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
    
    private var weatherDTO: WeatherDTO?
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
        
        handleCandiceSpecialValue(currentTemperature: dto.currently.temperature.converted(to: .fahrenheit).value)
	}
	
}

// MARK: - Helper Methods
extension WeatherViewModel {
	var candiceSpecialValue: Int {
		let candiceSpecial = FunManager.shared.candiceSpecialCounter
		return candiceSpecial
	}
	
	private func loadNewWeatherData(_ dto: WeatherDTO) {
        self.weatherDTO = dto
        
		let cityName = LocationManager.shared.currentPlacemark.addressString
		let newWeatherViewModel = WeatherViewModel(dto: dto)
		
		self.locationVM.cityName = cityName
		
		self.alertViewModels = newWeatherViewModel.alertViewModels
		self.hourlyViewModel = newWeatherViewModel.hourlyViewModel
		self.dailyViewModel = newWeatherViewModel.dailyViewModel
		self.currentlyViewModel = newWeatherViewModel.currentlyViewModel
	}
	
    func updateWeatherData() async {
        guard let sureLatitude = LocationManager.shared.currentPlacemark.latitude,
              let sureLongitude = LocationManager.shared.currentPlacemark.longitude else { return }
        
        let weatherDTOResult = await WeatherKitManager.getWeatherDTO(latitude: sureLatitude, longitude: sureLongitude)
        switch weatherDTOResult {
            case .success(let dto):
                await MainActor.run {
                    loadNewWeatherData(dto)
                    handleCandiceSpecialValue(currentTemperature: dto.currently.temperature.value)
                }
            case .failure(let error):
                print(error)
        }
    }
    
    private func handleCandiceSpecialValue(currentTemperature: Double) {
        if FunManager.shared.shouldIncrementCandiceSpecialValue(currentTemperature: currentTemperature) {
            FunManager.shared.incrementCandiceSpecialValue()
        }
    }
}
