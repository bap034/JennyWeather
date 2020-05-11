//
//  IconUtility.swift
//  JennyWeather
//
//  Created by Brett Petersen on 5/10/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

enum WeatherIcon: String {
	
	// DarkSky provided icon names: https://darksky.net/dev/docs#data-point-object
	case clearDay = "clear-day"
	case clearNight = "clear-night"
	case rain
	case snow
	case sleet
	case wind
	case fog
	case cloudy
	case partlyCloudyDay = "partly-cloudy-day"
	case partlyCloudyNight = "partly-cloudy-night"
	
	/// Manually created
	case umbrella
	
	/// Used if provided icon name does not match, we set the enum to this value
	case unknown
	
	var systemIconName: String {
		switch self {
			case .clearDay:
				return "sun.max"
			case .clearNight:
				return "moon.stars"
			case .rain:
				return "cloud.rain"
			case .snow:
				return "cloud.snow"
			case .sleet:
				return "cloud.sleet"
			case .wind:
				return "wind"
			case .fog:
				return "cloud.fog"
			case .cloudy:
				return "cloud"
			case .partlyCloudyDay:
				return "cloud.sun"
			case .partlyCloudyNight:
				return "cloud.moon"
			case .umbrella:
				return "umbrella"
			case .unknown:
				return "questionmark.circle"
		}
	}
}

class IconUtility {
	
	static func getWeatherIcon(darkSkyIconName: String) -> WeatherIcon {
		let weatherIcon = WeatherIcon(rawValue: darkSkyIconName) ?? .unknown
		return weatherIcon
	}
	
}
