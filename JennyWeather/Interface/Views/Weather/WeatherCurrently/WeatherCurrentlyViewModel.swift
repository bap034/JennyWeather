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
    @Published var precipProbabilityText: String
    
    @Published var icon: String
	@Published var temperatureText: String
	@Published var windSpeedText: String
	@Published var timeString: String
	
	init(currentlyDTO: WeatherCurrentlyDTO, minutelyDTO: WeatherMinutelyDTO?) {
		minutelySummary = minutelyDTO?.summary
        let precipProbability = minutelyDTO?.data.first?.precipProbability ?? 0
        precipProbabilityText = WeatherKitManager.getPrecipProbabilityText(precipProbability: precipProbability)
        
        icon = currentlyDTO.icon
        temperatureText = Measurement.defaultFormatter.string(from: currentlyDTO.temperature)
		windSpeedText = Measurement.defaultFormatter.string(from: currentlyDTO.windSpeed)
		timeString = "Last updated at \(NetworkUtility.shared.timeOnlyFormatter.string(from: currentlyDTO.time))"
	}
	
}
