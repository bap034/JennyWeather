//
//  WeatherLoadingView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/26/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherLoadingView: View {
	
	@State var error: Error? = nil
	
    var body: some View {
		ZStack {
			ThemeManager.shared.currentTheme.colors.baseLightColor
				.edgesIgnoringSafeArea(.all)
			
			getText(error: error)
				.padding(10)
		}
    }
	
	private func getText(error: Error?) -> Text {
		let text = error?.localizedDescription ?? "Loading..."
		return Text(text)
			.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
			.font(ThemeManager.shared.currentTheme.fonts.primaryFont)
	}
}

struct WeatherLoadingView_Previews: PreviewProvider {
    static var previews: some View {
//		let error = JWError.unexpectedNil
//		let view = WeatherLoadingView(error: error)
		let view = WeatherLoadingView()
		return view
    }
}
