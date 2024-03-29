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
		let temperatureString: String
		if UserDefaultsUtility.isUsingMetricSystem {
			temperatureString = String(format: "%.0f°C", self)
		} else {
			temperatureString = String(format: "%.0f°F", self)
		}
		return temperatureString
	}
	
	var toRainString: String {
		let rainString = String(format: "%.0f%%", self*100)
		return rainString
	}
	
	var toWindString: String {
		let windString: String
		if UserDefaultsUtility.isUsingMetricSystem {
			windString = String(format: "%.1f m/s", self)
		} else {
			windString = String(format: "%.1f mph", self)
		}
		return windString
	}
}
