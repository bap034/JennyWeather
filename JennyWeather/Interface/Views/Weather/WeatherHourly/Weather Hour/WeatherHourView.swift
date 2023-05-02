//
//  WeatherHourView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 9/7/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherHourView: View {
	
	@ObservedObject var weatherHourVM: WeatherHourViewModel
	
    var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Image(systemName: weatherHourVM.icon)
					.resizable()
					.scaledToFit()
					.frame(height: 30)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.complimentaryColor)
				
				Spacer()
				
				Text(weatherHourVM.temperatureText)
					.font(ThemeManager.shared.currentTheme.fonts.headerFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
			}
			.layoutPriority(.infinity)
			
			VStack(alignment: .trailing) {
				Text(weatherHourVM.timeString)
					.font(ThemeManager.shared.currentTheme.fonts.primaryFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
					.frame(minWidth: 90, alignment: .trailing)					
				
				if weatherHourVM.showPrecipitation {
					HStack {
						Text(weatherHourVM.precipProbabilityText)
							.font(ThemeManager.shared.currentTheme.fonts.secondaryFont)
							.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
						
						Image(systemName: "umbrella")
							.resizable()
							.scaledToFit()
							.frame(maxHeight: 20)
							.foregroundColor(ThemeManager.shared.currentTheme.colors.complimentaryColor)
					}
				} else {
					Spacer()
				}
				
				Text(weatherHourVM.windSpeedText)
					.font(ThemeManager.shared.currentTheme.fonts.secondaryFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
			}
		}
		.padding([.leading, .trailing], 10)
    }
}

struct WeatherHourView_Previews: PreviewProvider {
    static var previews: some View {
		let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		let hourVM = weatherVM.hourlyViewModel.hourVMs.first!
		
		let view = WeatherHourView(weatherHourVM: hourVM)
		return view
    }
}
