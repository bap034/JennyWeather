//
//  JWColors.swift
//  JennyWeather
//
//  Created by Brett Petersen on 9/7/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

/// Using a complimentary color styling: https://color.adobe.com/create/color-wheel
protocol ColorStyling {
	var baseDarkColor: Color { get }
	var baseColor: Color { get }
	var baseLightColor: Color { get }
	var complimentaryDarkColor: Color { get }
	var complimentaryLightColor: Color { get }
}

struct JWColors {
	static let defaultColors:ColorStyling = DefaultColorStyling()
}

// MARK: - Default Color Styling
struct DefaultColorStyling: ColorStyling {
	var baseDarkColor: Color {
		return Color(red: 179.0/255, green: 111.0/255, blue: 59.0/255)
	}
	
	var baseColor: Color {
		return Color(red: 255.0/255, green: 173.0/255, blue: 109.0/255)
	}
	
	var baseLightColor: Color {
		return Color(red: 255.0/255, green: 210.0/255, blue: 176.0/255)
	}
	
	var complimentaryDarkColor: Color {
		return Color(red: 41.0/255, green: 163.0/255, blue: 179.0/255)
	}
	
	var complimentaryLightColor: Color {
		return Color(red: 110.0/255, green: 238.0/255, blue: 255.0/255)
	}
}
