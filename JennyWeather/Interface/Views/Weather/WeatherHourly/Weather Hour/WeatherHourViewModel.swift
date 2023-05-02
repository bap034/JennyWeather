//
//  WeatherHourViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 9/7/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherHourViewModel: ObservableObject {
	
	private let dto: WeatherHourDTO
	
	@Published var icon: String
	@Published var precipProbabilityText: String
	@Published var temperatureText: String
	@Published var windSpeedText: String
	@Published var timeString: String
	
	var showPrecipitation:Bool {
        return dto.precipType.isPrecipitating
	}
	
	init(dto: WeatherHourDTO) {
		self.dto = dto
		
		icon = dto.icon
        precipProbabilityText = WeatherKitManager.getPrecipProbabilityText(precipProbability: dto.precipProbability)
        temperatureText = Measurement.defaultFormatter.string(from: dto.temperature)
		windSpeedText = Measurement.defaultFormatter.string(from: dto.windSpeed)
		timeString = NetworkUtility.shared.timeOnlyFormatter.string(from: dto.time)
	}
	
}

// MARK: Identifiable
extension WeatherHourViewModel: Identifiable {
	var id: Int { return dto.id }
}
