//
//  WeatherAlertDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 5/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

struct WeatherAlertDTO: Codable {
    let region: String?
    let severity: String // Update this to keep severity enum value
    let summary: String
    let detailsUrl: URL
    let source: String
}
