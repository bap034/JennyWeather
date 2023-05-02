//
//  WeatherDayViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 9/7/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherDayViewModel: ObservableObject {
	
	private let dto: WeatherDayDTO
	
	@Published var timeString: String
	@Published var icon: String
	@Published var precipProbabilityText: String
	@Published var temperatureHighText: String
	@Published var temperatureLowText: String
	@Published var windSpeedText: String
	
	var showPrecipitation:Bool {
        dto.precipType.isPrecipitating
	}
	
	init(dto: WeatherDayDTO) {
		self.dto = dto
		
		timeString = WeatherDayViewModel.getTimeString(date: dto.time)
		icon = dto.icon
		precipProbabilityText = WeatherKitManager.getPrecipProbabilityText(precipProbability: dto.precipProbability)
        temperatureHighText = Measurement.defaultFormatter.string(from: dto.temperatureHigh)
		temperatureLowText = Measurement.defaultFormatter.string(from: dto.temperatureLow)
		windSpeedText = Measurement.defaultFormatter.string(from: dto.windSpeed)
	}
	
	private static func getTimeString(date: Date) -> String {
		var timeString = ""
		let calendar = Calendar.current
		if calendar.isDateInToday(date) {
			timeString = "Today"
		} else if calendar.isDateInTomorrow(date) {
			timeString = "Tomorrow"
		} else {
			let dateformatter = DateFormatter()
			dateformatter.dateFormat = "EEEE"
			timeString = dateformatter.string(from: date)
		}
		return timeString
	}
}

// MARK: Identifiable
extension WeatherDayViewModel: Identifiable {
	var id: Int { return dto.id }
}
