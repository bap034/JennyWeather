//
//  WeatherCurrentlyViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherCurrentlyViewModel: ObservableObject {
	
	@Published var minutelySummary: String?
	
	@Published var timestamp: Int
	@Published var summary: String
	@Published var icon: WeatherIcon
	@Published var precipProbability: Double
	@Published var temperature: Double
	@Published var windSpeed: Double
	@Published var time: Date
	@Published var timeString: String
	
	init(currentlyDTO: WeatherCurrentlyDTO, minutelyDTO: WeatherMinutelyDTO) {
		minutelySummary = minutelyDTO.summary
		
		timestamp = currentlyDTO.timestamp
		summary = currentlyDTO.summary
		icon = IconUtility.getWeatherIcon(darkSkyIconName: currentlyDTO.icon)
		precipProbability = currentlyDTO.precipProbability
		temperature = currentlyDTO.temperature
		windSpeed = currentlyDTO.windSpeed
		time = currentlyDTO.time
		timeString = NetworkUtility.shared.dateFormatter.string(from: currentlyDTO.time)
	}
	
}
