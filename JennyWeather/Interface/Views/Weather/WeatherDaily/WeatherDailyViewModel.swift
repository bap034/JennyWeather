//
//  WeatherDailyViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherDailyViewModel: ObservableObject {
	
	@Published var dayVMs: [WeatherDayViewModel]
	
	init(dto: WeatherDailyDTO) {
		var dayVMs = [WeatherDayViewModel]()
		dto.data.forEach { (dayDTO) in
			let dayData = WeatherDayViewModel(dto: dayDTO)
			dayVMs.append(dayData)
		}
		self.dayVMs = dayVMs
	}
	
}
