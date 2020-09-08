//
//  WeatherHourlyView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/26/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherHourlyView: View {
    
	@ObservedObject var weatherHourlyVM: WeatherHourlyViewModel
	
    var body: some View {
		VStack(alignment: .leading) {
			Text("Hourly")
				.font(ThemeManager.shared.currentTheme.fonts.headerFont)
				.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
				.padding(.bottom, 10)
				.padding(.leading, 20)
			
			Text(weatherHourlyVM.summary)
				.font(ThemeManager.shared.currentTheme.fonts.primaryFont)
				.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
				.fixedSize(horizontal: false, vertical: true)
				.padding(.bottom, 10)
				.padding([.leading, .trailing], 20)
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 0) {
					ForEach(weatherHourlyVM.hourVMs) { hourVM in
						WeatherHourView(weatherHourVM: hourVM)
						
						if hourVM.id != self.weatherHourlyVM.hourVMs.last?.id {
							Divider()
								.background(ThemeManager.shared.currentTheme.colors.baseLightColor)
						}
					}
				}
				.padding([.leading, .trailing], 10)
			}
			.frame(height: 90)
		}
    }
}

struct WeatherHourlyView_Previews: PreviewProvider {
    static var previews: some View {
        let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		
		let view = WeatherHourlyView(weatherHourlyVM: weatherVM.hourlyViewModel)
		return view
    }
}
