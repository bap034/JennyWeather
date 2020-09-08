//
//  JWThemes.swift
//  JennyWeather
//
//  Created by Brett Petersen on 9/7/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import UIKit

protocol Theme {
	var fonts: FontStyling { get }
	var colors: ColorStyling { get }
}

struct JWThemes {
	static let defaultTheme:Theme = DefaultTheme()
}

// MARK: - Default Theme
struct DefaultTheme: Theme {
	var fonts: FontStyling {
		return JWFonts.defaultFonts
	}
	
	var colors: ColorStyling {
		return JWColors.defaultColors
	}
}
