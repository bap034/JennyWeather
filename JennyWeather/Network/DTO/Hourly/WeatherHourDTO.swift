//
//  WeatherHourDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 5/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

struct WeatherHourDTO: Codable {
    let icon: String
    let precipType: PrecipitationType
    let precipProbability: Double
    let temperature: Measurement<UnitTemperature>
    let windSpeed: Measurement<UnitSpeed>
    let time: Date
}

// MARK: - Identifiable
extension WeatherHourDTO: Identifiable {
    var id: Int { return Int(time.timeIntervalSince1970) }
}
