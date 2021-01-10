//
//  JWThemes.swift
//  JennyWeather
//
//  Created by Brett Petersen on 9/7/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import UIKit

enum ThemeType {
	case standard
	case rain
}

struct Theme {
	let themeType: ThemeType
	let fonts: FontStyle
	let colors: ColorStyle
}

// MARK: - Utility Access Struct
struct JWThemes {
	// MARK: Standard
	static let standardTheme = Theme(themeType: .standard,
									fonts: DefaultFontStyle(),
									colors: DefaultColorStyle())
	
	// MARK: Rain
	static let rainTheme = Theme(themeType: .rain,
								 fonts: DefaultFontStyle(),
								 colors: RainColorStyle())
	
	static let rainDarkTheme = Theme(themeType: .rain,
									 fonts: DefaultFontStyle(),
									 colors: RainDarkColorStyle())
}
