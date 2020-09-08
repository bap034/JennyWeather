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
