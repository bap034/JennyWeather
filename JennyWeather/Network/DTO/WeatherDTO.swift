//
//  WeatherDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 5/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

struct WeatherDTO: Codable {
	let alerts: [WeatherAlertDTO]?
	let minutely: WeatherMinutelyDTO?
	let hourly: WeatherHourlyDTO
	let daily: WeatherDailyDTO
	let currently: WeatherCurrentlyDTO
}
