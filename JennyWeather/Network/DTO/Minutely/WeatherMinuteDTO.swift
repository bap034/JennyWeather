//
//  WeatherMinuteDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 4/21/23.
//  Copyright © 2023 Brett Petersen. All rights reserved.
//

import Foundation

struct WeatherMinuteDTO: Codable {
    let precipType: PrecipitationType
    let precipProbability: Double
    let time: Date
}
