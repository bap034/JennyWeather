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
		return Font.system(size: 30, weight: .bold, design: .default)
	}
	
	var headerFont: Font {
		return Font.system(size: 22, weight: .medium, design: .default)
	}
	
	var primaryFont: Font {
		return Font.system(size: 14, weight: .medium, design: .default)
	}
	
	var secondaryFont: Font {
		return Font.system(size: 14, weight: .regular, design: .default)
	}
	
	var tertiaryFont: Font {
		return Font.system(size: 12, weight: .light, design: .default)
	}
	
	var actionFont: Font {
		return Font.system(size: 16, weight: .medium, design: .default)
	}
}
