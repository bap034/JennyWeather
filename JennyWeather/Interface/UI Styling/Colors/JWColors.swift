//
//  JWColors.swift
//  JennyWeather
//
//  Created by Brett Petersen on 9/7/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

/// Using a `shades` color styling with a single `complimentary` value: https://color.adobe.com/create/color-wheel
protocol ColorStyle {
	var baseDarkColor: Color { get }
	var baseColor: Color { get }
	var baseLightColor: Color { get }
	var complimentaryColor: Color { get }
	
	/// Temporary UIColor requirement for UINavigationController color
	var baseDarkUIColor: UIColor { get }
	var baseLightUIColor: UIColor { get }
}

// MARK: - Helper Methods
extension Color {
	/// This is a convenience method that takes in an `Int` and divides it by `255` so we don't need provide the `CGFloat` version.
	fileprivate init(redIntValue: Int, greenIntValue: Int, blueIntValue: Int) {
		let redCGFloatValue = CGFloat(redIntValue) / 255.0
		let greenCGFloatValue = CGFloat(greenIntValue) / 255.0
		let blueCGFloatValue = CGFloat(blueIntValue) / 255.0
		self.init(UIColor(red: redCGFloatValue, green: greenCGFloatValue, blue: blueCGFloatValue, alpha: 1))
	}
}
extension UIColor {
	/// This is a convenience method that takes in an `Int` and divides it by `255` so we don't need provide the `CGFloat` version.
	fileprivate convenience init(redIntValue: Int, greenIntValue: Int, blueIntValue: Int) {
		let redCGFloatValue = CGFloat(redIntValue) / 255.0
		let greenCGFloatValue = CGFloat(greenIntValue) / 255.0
		let blueCGFloatValue = CGFloat(blueIntValue) / 255.0
		self.init(red: redCGFloatValue, green: greenCGFloatValue, blue: blueCGFloatValue, alpha: 1)
	}
}

// MARK: - Color Styles
// MARK: Default Color Styling
struct DefaultColorStyle: ColorStyle {
	var baseDarkColor: Color {
		return Color(baseDarkUIColor)
	}
	
	var baseColor: Color {
		return Color(redIntValue: 255, greenIntValue: 173, blueIntValue: 109)
	}
	
	var baseLightColor: Color {
		return Color(baseLightUIColor)
	}
	
	var complimentaryColor: Color {
		return Color(redIntValue: 41, greenIntValue: 163, blueIntValue: 179)
	}
	
	var baseDarkUIColor: UIColor {
		return UIColor(redIntValue: 179, greenIntValue: 111, blueIntValue: 59)
	}
	var baseLightUIColor: UIColor {
		return UIColor(redIntValue: 255, greenIntValue: 210, blueIntValue: 176)
	}
}

// MARK: - Rain Color Styling
struct RainColorStyle: ColorStyle {
	var baseDarkColor: Color {
		return Color(baseDarkUIColor)
	}
	
	var baseColor: Color {
		return Color(redIntValue: 129, greenIntValue: 240, blueIntValue: 255)
	}
	
	var baseLightColor: Color {
		return Color(baseLightUIColor)
	}
	
	var complimentaryColor: Color {
		return Color(redIntValue: 179, greenIntValue: 119, blueIntValue: 109)
	}
	
	var baseDarkUIColor: UIColor {
		return UIColor(redIntValue: 33, greenIntValue: 60, blueIntValue: 64)
	}
	var baseLightUIColor: UIColor {
		return UIColor(redIntValue: 207, greenIntValue: 249, blueIntValue: 255)
	}
}
