//
//  ThemeManager.swift
//  JennyWeather
//
//  Created by Brett Petersen on 9/7/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import Foundation

class ThemeManager {
	private static let defaultThemeType = ThemeType.rain
	
	static let shared = ThemeManager()
	
	var currentTheme = ThemeManager.getTheme(themeType: defaultThemeType, isDarkMode: false)
	
	static func getTheme(themeType: ThemeType, isDarkMode: Bool) -> Theme {
		if isDarkMode {
			switch themeType {
				case .standard: return JWThemes.standardTheme
				case .rain: return JWThemes.rainDarkTheme
			}
		} else {
			switch themeType {
				case .standard: return JWThemes.standardTheme
				case .rain: return JWThemes.rainTheme
			}
		}
	}
}
