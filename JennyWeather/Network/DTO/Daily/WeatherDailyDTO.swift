//
//  WeatherDailyDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 5/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

struct WeatherDailyDTO: Codable {
    let data: [WeatherDayDTO]	    
}
