//
//  JWThemes.swift
//  JennyWeather
//
//  Created by Brett Petersen on 9/7/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import UIKit

struct Theme {
	let fonts: FontStyle
	let colors: ColorStyle
}

struct JWThemes {
	static let defaultTheme = Theme(fonts: DefaultFontStyle(),
									colors: DefaultColorStyle())
	
	static let rainTheme = Theme(fonts: DefaultFontStyle(),
								 colors: RainColorStyle())
}
