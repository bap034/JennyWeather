//
//  WeatherCurrentlyDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 4/25/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

struct WeatherCurrentlyDTO: Codable {
    let icon: String
    let temperature: Measurement<UnitTemperature>
    let windSpeed: Measurement<UnitSpeed>
    let time: Date
}
