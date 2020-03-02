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
	@ObservedObject var locationVM: WeatherLocationViewModel
	
	var body: some View {
		NavigationView {
			ScrollView {
				
				WeatherLocationView(locationVM: locationVM)
					.padding(.top, 30)
				
				WeatherCurrentlyView(weatherCurrentlyVM: weatherVM.currentlyViewModel, weatherMinutelyVM: weatherVM.minutelyViewModel)
					.padding(.bottom, 30)
				
				Divider()
				
				WeatherHourlyView(weatherHourlyVM: weatherVM.hourlyViewModel)
				
				Divider()
				
				WeatherDailyView(weatherDailyVM: weatherVM.dailyViewModel)
				
				Text("Powered by Dark Sky")
					.font(.caption)
					.frame(alignment: .trailing)
					.padding(.top, 40)
					.padding(.bottom, 20)
					.onTapGesture {
						if let sureURL = URL(string: "https://darksky.net/poweredby/") {
							UIApplication.shared.open(sureURL, options: [:], completionHandler: nil)
						}
				}
			}
			.navigationBarTitle("🤓 The Jenny Weather App! ☀️", displayMode: .inline)
		}
	}
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
		let weatherVM: WeatherViewModel = try! WeatherMockData.getWeatherViewModel()
		let locationVM = WeatherLocationViewModel(city: "Berkeley")
		
		let view = WeatherView(weatherVM: weatherVM, locationVM: locationVM)
		return view
	}
}
