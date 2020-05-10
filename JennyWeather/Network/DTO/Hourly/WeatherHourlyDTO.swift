//
//  WeatherHourlyDTO.swift
//  JennyWeather
//
//  Created by Brett Petersen on 5/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

struct WeatherHourlyDTO: Codable {
	
	var summary: String
	var icon: String
	var data: [WeatherHourDTO]
	    
}

