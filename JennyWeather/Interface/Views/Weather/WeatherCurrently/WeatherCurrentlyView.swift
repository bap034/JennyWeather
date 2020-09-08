//
//  WeatherCurrentlyView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/12/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherCurrentlyView: View {
	
	@ObservedObject var weatherCurrentlyVM: WeatherCurrentlyViewModel
	
	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				HStack {
					VStack(alignment: .leading) {
						Text("Currently")
							.font(ThemeManager.shared.currentTheme.fonts.headerFont)
							.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
						
						Text(weatherCurrentlyVM.timeString)
							.font(ThemeManager.shared.currentTheme.fonts.tertiaryFont)
							.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
							.padding(.bottom, 10)
					}
					
					Spacer()
					
					Image(systemName: weatherCurrentlyVM.icon.systemIconName)
						.resizable()
						.scaledToFit()
						.frame(height: 50)
						.foregroundColor(ThemeManager.shared.currentTheme.colors.complimentaryDarkColor)
				}
				
				Text(weatherCurrentlyVM.minutelySummary)
					.font(ThemeManager.shared.currentTheme.fonts.primaryFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
					.fixedSize(horizontal: false, vertical: true)
					.padding(.bottom, 10)
				
				HStack {
					Text(weatherCurrentlyVM.temperature.toTemperatureString)
						.font(ThemeManager.shared.currentTheme.fonts.headerFont)
						.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
					
					Text(weatherCurrentlyVM.precipProbability.toRainString)
						.font(ThemeManager.shared.currentTheme.fonts.secondaryFont)
						.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
					
					Text(weatherCurrentlyVM.windSpeed.toWindString)
						.font(ThemeManager.shared.currentTheme.fonts.secondaryFont)
						.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
				}
			}
			.padding([.leading, .trailing], 20)
			
			Spacer()
		}
    }
}

struct WeatherCurrentlyView_Previews: PreviewProvider {
    static var previews: some View {
		let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		
		let view = WeatherCurrentlyView(weatherCurrentlyVM: weatherVM.currentlyViewModel)
		return view
    }
}
