//
//  JWFonts.swift
//  JennyWeather
//
//  Created by Brett Petersen on 9/7/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

protocol FontStyling {
	var titleFont: Font { get }
	var headerFont: Font { get }
	var primaryFont: Font { get }
	var secondaryFont: Font { get }
	var tertiaryFont: Font { get }
	var actionFont: Font { get }
}

struct JWFonts {
	static let defaultFonts:FontStyling = DefaultFontStyling()
}

// MARK: - Default Font Styling
struct DefaultFontStyling: FontStyling {
	var titleFont: Font {
		return Font.system(size: 36, weight: .bold, design: .rounded)
	}
	
	var headerFont: Font {
		return Font.system(size: 24, weight: .medium, design: .rounded)
	}
	
	var primaryFont: Font {
		return Font.system(size: 18, weight: .medium, design: .rounded)
	}
	
	var secondaryFont: Font {
		return Font.system(size: 18, weight: .regular, design: .rounded)
	}
	
	var tertiaryFont: Font {
		return Font.system(size: 16, weight: .light, design: .rounded)
	}
	
	var actionFont: Font {
		return Font.system(size: 20, weight: .medium, design: .rounded)
	}
}
