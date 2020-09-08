//
//  WeatherHourlyViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherHourlyViewModel: ObservableObject {
	
	@Published var summary: String
	@Published var icon: WeatherIcon
	@Published var hourVMs: [WeatherHourViewModel]
	
	init(dto: WeatherHourlyDTO) {
		summary = dto.summary
		icon = IconUtility.getWeatherIcon(darkSkyIconName: dto.icon)
		
		var hourVMs = [WeatherHourViewModel]()
		dto.data.forEach { (hourDataJson) in
			let hourData = WeatherHourViewModel(dto: hourDataJson)
			hourVMs.append(hourData)
		}
		/// DarkSky provides more than 24 hours worth of data.
		let truncatedVMs = hourVMs.prefix(upTo: 25)
		self.hourVMs = Array(truncatedVMs)
	}
	
}
