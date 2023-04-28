//
//  WeatherHourlyViewModel.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/11/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class WeatherHourlyViewModel: ObservableObject {
	
	@Published var hourVMs: [WeatherHourViewModel]
	
	init(dto: WeatherHourlyDTO) {
		var hourVMs = [WeatherHourViewModel]()
		dto.data.forEach { (hourDataJson) in
			let hourData = WeatherHourViewModel(dto: hourDataJson)
			hourVMs.append(hourData)
		}
		/// WeatherKit provides more than 24 hours worth of data.
        let maxCount = min(hourVMs.count, 24)
        let truncatedVMs = hourVMs.prefix(upTo: maxCount)
		self.hourVMs = Array(truncatedVMs)
	}
	
}
