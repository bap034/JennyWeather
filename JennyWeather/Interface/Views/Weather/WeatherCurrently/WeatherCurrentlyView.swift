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
						
						Spacer()
						
						Text(weatherCurrentlyVM.timeString)
							.font(ThemeManager.shared.currentTheme.fonts.tertiaryFont)
							.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
							.padding(.bottom, 10)
					}
					
					Spacer()
					
					VStack(alignment: .trailing) {
                        Text(weatherCurrentlyVM.temperatureText)
						.font(ThemeManager.shared.currentTheme.fonts.titleFont)
						.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
					
						HStack {
							Text(weatherCurrentlyVM.precipProbabilityText)
								.font(ThemeManager.shared.currentTheme.fonts.tertiaryFont)
								.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
							
							Text(weatherCurrentlyVM.windSpeedText)
								.font(ThemeManager.shared.currentTheme.fonts.tertiaryFont)
								.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
						}
					}
					
					Image(systemName: weatherCurrentlyVM.icon)
						.resizable()
						.scaledToFit()
						.frame(height: 50)
						.foregroundColor(ThemeManager.shared.currentTheme.colors.complimentaryColor)
				}				
                if let sureMinutelySummary = weatherCurrentlyVM.minutelySummary, !sureMinutelySummary.isEmpty {
                    Text(sureMinutelySummary)
                        .font(ThemeManager.shared.currentTheme.fonts.secondaryFont)
                        .foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
                        .fixedSize(horizontal: false, vertical: true)
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
		
		let view = WeatherCurrentlyView(weatherCurrentlyVM: weatherVM.currentlyViewModel).frame(height: 100)
		return view
    }
}
