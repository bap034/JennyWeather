//
//  WeatherDayView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 9/7/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherDayView: View {
	@ObservedObject var weatherDayVM: WeatherDayViewModel
	
    var body: some View {
		VStack(alignment: .leading) {
			Text(weatherDayVM.timeString)
				.font(ThemeManager.shared.currentTheme.fonts.primaryFont)
				.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
			HStack {
				VStack {
					Image(systemName: weatherDayVM.icon.systemIconName)
						.resizable()
						.scaledToFit()
						.frame(width: 50, height: 30)
						.foregroundColor(ThemeManager.shared.currentTheme.colors.complimentaryColor)
					
					if weatherDayVM.showPrecipitation {
						Text(weatherDayVM.precipProbability.toRainString)
							.font(ThemeManager.shared.currentTheme.fonts.secondaryFont)
							.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
							.frame(width: 50)
					}
				}
				
				Divider()
					.background(ThemeManager.shared.currentTheme.colors.baseLightColor)
				
				Text(weatherDayVM.temperatureHigh.toTemperatureString)
					.font(ThemeManager.shared.currentTheme.fonts.headerFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
				
				Text(weatherDayVM.temperatureLow.toTemperatureString)
					.font(ThemeManager.shared.currentTheme.fonts.secondaryFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
				
				Divider()
					.background(ThemeManager.shared.currentTheme.colors.baseLightColor)
				
				Text(weatherDayVM.windSpeed.toWindString)
					.font(ThemeManager.shared.currentTheme.fonts.secondaryFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
			}
		}
    }
}

struct WeatherDayView_Previews: PreviewProvider {
    static var previews: some View {
		let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		let dayVM = weatherVM.dailyViewModel.dayVMs.first!
		
		let view = WeatherDayView(weatherDayVM: dayVM)
		return view
    }
}
