//
//  Double+JW.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/26/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

extension Double {
	var toTemperatureString: String {
		let temperatureString = String(format: "%.0f ℉", self)
		return temperatureString
	}
	
	var toRainString: String {
		let rainString = String(format: "%.1f %%", self*100)
		return rainString
	}
	
	var toWindString: String {
		let windString = String(format: "%.2f mph", self)
		return windString
	}
}
