//
//  WeatherDailyViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherDailyViewModel: ObservableObject {
	
	@Published var summary: String
	@Published var icon: WeatherIcon
	@Published var dayVMs: [WeatherDayViewModel]
	
	init(dto: WeatherDailyDTO) {
		summary = dto.summary
		icon = IconUtility.getWeatherIcon(darkSkyIconName: dto.icon)
		
		var dayVMs = [WeatherDayViewModel]()
		dto.data.forEach { (dayDTO) in
			let dayData = WeatherDayViewModel(dto: dayDTO)
			dayVMs.append(dayData)
		}
		self.dayVMs = dayVMs
	}
	
}

// MARK: - Data Object
class WeatherDayViewModel: ObservableObject {
	
	private let dto: WeatherDayDTO
	
	@Published var timeString: String
	@Published var summary: String
	@Published var icon: WeatherIcon
	@Published var precipProbability: Double
	@Published var temperatureHigh: Double
	@Published var temperatureLow: Double
	@Published var windSpeed: Double
	
	init(dto: WeatherDayDTO) {
		self.dto = dto
				
		timeString = WeatherDayViewModel.getTimeString(date: dto.time)
		summary = dto.summary
		icon = IconUtility.getWeatherIcon(darkSkyIconName: dto.icon)
		precipProbability = dto.precipProbability
		temperatureHigh = dto.temperatureHigh
		temperatureLow = dto.temperatureLow
		windSpeed = dto.windSpeed
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
