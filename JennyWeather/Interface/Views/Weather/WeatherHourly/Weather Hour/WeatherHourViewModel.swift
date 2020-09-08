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
	
	@Published var summary: String
	@Published var icon: WeatherIcon
	@Published var precipProbability: Double
	@Published var temperature: Double
	@Published var windSpeed: Double
	@Published var timeString: String
	
	var showPrecipitation:Bool {
		return precipProbability >= 0.05
	}
	
	init(dto: WeatherHourDTO) {
		self.dto = dto
		
		summary = dto.summary
		icon = IconUtility.getWeatherIcon(darkSkyIconName: dto.icon)
		precipProbability = dto.precipProbability
		temperature = dto.temperature
		windSpeed = dto.windSpeed
		timeString = NetworkUtility.shared.timeOnlyFormatter.string(from: dto.time)
	}
	
}

// MARK: Identifiable
extension WeatherHourViewModel: Identifiable {
	var id: Int { return dto.id }
}
