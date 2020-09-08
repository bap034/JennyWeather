//
//  JWFonts.swift
//  JennyWeather
//
//  Created by Brett Petersen on 9/7/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import UIKit

protocol FontStyling {
	var titleFont: UIFont { get }
	var headerFont: UIFont { get }
	var primaryFont: UIFont { get }
	var secondaryFont: UIFont { get }
	var tertiaryFont: UIFont { get }
	var actionFont: UIFont { get }
}

struct JWFonts {
	static let defaultFonts:FontStyling = DefaultFontStyling()
}

// MARK: - Default Font Styling
struct DefaultFontStyling: FontStyling {
	var titleFont: UIFont {
		return UIFont.systemFont(ofSize: 36, weight: .bold)
	}
	
	var headerFont: UIFont {
		return UIFont.systemFont(ofSize: 24, weight: .medium)
	}
	
	var primaryFont: UIFont {
		return UIFont.systemFont(ofSize: 18, weight: .medium)
	}
	
	var secondaryFont: UIFont {
		return UIFont.systemFont(ofSize: 18, weight: .regular)
	}
	
	var tertiaryFont: UIFont {
		return UIFont.systemFont(ofSize: 14, weight: .light)
	}
	
	var actionFont: UIFont {
		return UIFont.systemFont(ofSize: 20, weight: .medium)
	}
}
