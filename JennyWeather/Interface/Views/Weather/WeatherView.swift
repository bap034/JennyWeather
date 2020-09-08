//
//  WeatherView.swift
//  JennyWeather
//
//  Created by Brett Petersen on 2/9/20.
//  Copyright © 2020 Brett Petersen. All rights reserved.
//

import SwiftUI

struct WeatherView: View {
	
	@ObservedObject var weatherVM: WeatherViewModel
	
	init(weatherVM: WeatherViewModel) {
		self.weatherVM = weatherVM
	
		/// NOTE: These `appeaerance()` changes are *GLOBAL* and affect all instances of that class.
		UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().largeTitleTextAttributes = [
			.font : UIFont.boldSystemFont(ofSize: 25),
			.foregroundColor : ThemeManager.shared.currentTheme.colors.baseDarkUIColor
		]
		UINavigationBar.appearance().titleTextAttributes = [
			.foregroundColor : ThemeManager.shared.currentTheme.colors.baseDarkUIColor
		]
		UINavigationBar.appearance().barTintColor = ThemeManager.shared.currentTheme.colors.baseLightUIColor
		
		UIScrollView.appearance().backgroundColor = ThemeManager.shared.currentTheme.colors.baseLightUIColor
		
		/// Used to remove default `white` background color:  https://stackoverflow.com/a/58427518
		UITableView.appearance().backgroundColor = .clear
		UITableViewCell.appearance().backgroundColor = .clear
    }
	
	var body: some View {
		NavigationView {
			ScrollView {
				WeatherLocationView(locationVM: weatherVM.locationVM)
					.padding(.top, 30)
				
				Divider()
					.background(ThemeManager.shared.currentTheme.colors.baseLightColor)
					.padding(.top, 10)
					.padding(.bottom, 10)
				
				WeatherCurrentlyView(weatherCurrentlyVM: weatherVM.currentlyViewModel)
				
				Divider()
					.background(ThemeManager.shared.currentTheme.colors.baseLightColor)
					.padding(.top, 15)
					.padding(.bottom, 10)
				
				WeatherHourlyView(weatherHourlyVM: weatherVM.hourlyViewModel)
				
				Divider()
					.background(ThemeManager.shared.currentTheme.colors.baseLightColor)
					.padding(.top, 15)
					.padding(.bottom, 10)
				
				WeatherDailyView(weatherDailyVM: weatherVM.dailyViewModel)
				
				Text("🎉 \(weatherVM.candiceSpecialValue)")
					.padding(.top, 30)
					.padding(.trailing, 20)
					.font(ThemeManager.shared.currentTheme.fonts.secondaryFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
				
				Text("Powered by Dark Sky")
					.font(ThemeManager.shared.currentTheme.fonts.tertiaryFont)
					.foregroundColor(ThemeManager.shared.currentTheme.colors.baseDarkColor)
					.padding(.top, 10)
					.padding(.bottom, 20)
					.onTapGesture {
						if let sureURL = URL(string: "https://darksky.net/poweredby/") {
							UIApplication.shared.open(sureURL, options: [:], completionHandler: nil)
						}
				}
			}
			.navigationBarTitle("🤓 The Jenny Weather App ☀️", displayMode: .automatic)
		}
	}
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
		let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		let locationVM = WeatherLocationViewModel()
		weatherVM.locationVM = locationVM
		
		let view = WeatherView(weatherVM: weatherVM)
		return view
	}
}
