//
//  WeatherDailyView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/26/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherDailyView: View {
    @ObservedObject var weatherDailyVM: WeatherDailyViewModel
	
    var body: some View {
		VStack(alignment: .leading) {
			Text("Daily")
				.font(ThemeManager.shared.currentTheme.fonts.headerFont)
				.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
				.padding(.bottom, 10)
				.padding(.leading, 20)
			
			Text(weatherDailyVM.summary)
				.font(ThemeManager.shared.currentTheme.fonts.primaryFont)
				.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
				.fixedSize(horizontal: false, vertical: true)
				.padding(.bottom, 10)
				.padding([.leading, .trailing], 20)
			
			ForEach(weatherDailyVM.dayVMs) { (dayVM) in
				WeatherDayView(weatherDayVM: dayVM)
				
				Divider()
					.background(ThemeManager.shared.currentTheme.colors.baseLightColor)
			}
			.padding([.leading, .trailing], 20)
		}
    }
}

struct WeatherDailyView_Previews: PreviewProvider {
    static var previews: some View {
        let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		
		let view = WeatherDailyView(weatherDailyVM: weatherVM.dailyViewModel)
		return view
    }
}
