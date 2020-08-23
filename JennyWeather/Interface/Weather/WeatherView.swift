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
		
		UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().largeTitleTextAttributes = [
			.font : UIFont.boldSystemFont(ofSize: 25)
		]
    }
	
	var body: some View {
		NavigationView {
			ScrollView {
				
				WeatherLocationView(locationVM: weatherVM.locationVM)
					.padding(.top, 30)
				
				WeatherCurrentlyView(weatherCurrentlyVM: weatherVM.currentlyViewModel)
					.padding(.bottom, 30)
				
				Divider()
				
				WeatherHourlyView(weatherHourlyVM: weatherVM.hourlyViewModel)
				
				Divider()
				
				WeatherDailyView(weatherDailyVM: weatherVM.dailyViewModel)
				
				Text("Powered by Dark Sky")
					.font(.caption)
					.padding(.top, 40)
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
